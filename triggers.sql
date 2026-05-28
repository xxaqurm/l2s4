CREATE OR REPLACE FUNCTION set_reg_date() -- 1
RETURNS TRIGGER AS $$
BEGIN 
    NEW.detective_time = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_set_incident_reg_date
    BEFORE INSERT ON incident
    FOR EACH ROW
    EXECUTE FUNCTION set_reg_date();

CREATE OR REPLACE FUNCTION check_severity_level() -- 2
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.sev_level < 0 OR NEW.sev_level > 100 THEN
    RAISE EXCEPTION 'Некорректный уровень критичности: %', NEW.sev_level;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_check_severity_level
    BEFORE INSERT ON severity_level
    FOR EACH ROW
    EXECUTE FUNCTION check_severity_level();

CREATE OR REPLACE FUNCTION check_incident_source() -- 3
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.id_incident_source IS NULL THEN
        RAISE EXCEPTION 'Невозможно добавить инцидент без указания источника его возникновения';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_check_incident_source
    BEFORE INSERT ON incident
    FOR EACH ROW
    EXECUTE FUNCTION check_incident_source();

CREATE OR REPLACE FUNCTION actions_aft_upd_resolve_incident()  -- 4
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM remedial_measure
        WHERE id_incident = NEW.id_incident
        AND exec_date IS NOT NULL
    ) THEN
        UPDATE incident
        SET status = 'устранен'
        WHERE id = NEW.id_incident;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER actions_aft_upd_resolve_incident_trigger
AFTER UPDATE ON remedial_measure
FOR EACH ROW
EXECUTE FUNCTION actions_aft_upd_resolve_incident();

CREATE OR REPLACE FUNCTION control_fix_deadline() -- 5
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.fixed_time IS NOT NULL
       AND NEW.detective_time IS NOT NULL
       AND NEW.fixed_time > NEW.detective_time + INTERVAL '72 hours' THEN
        NEW.processing_delay := TRUE;
    ELSE
        NEW.processing_delay := FALSE;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_control_fix_deadline
BEFORE UPDATE ON incident
FOR EACH ROW
EXECUTE FUNCTION control_fix_deadline();

CREATE OR REPLACE FUNCTION incidents_set_new_status_on_create()  -- 6
RETURNS TRIGGER AS $$
BEGIN
    NEW.status := 'новый';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER incidents_set_new_status_on_create_trigger
BEFORE INSERT ON incident
FOR EACH ROW
EXECUTE FUNCTION incidents_set_new_status_on_create();

CREATE OR REPLACE FUNCTION prevent_vulnerability_delete_with_incidents()  -- 7
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM incident
        WHERE id IN (
            SELECT id_incident
            FROM exploited_vulnerability
            WHERE id_vulnerability = OLD.id
        )
    ) THEN
        RAISE EXCEPTION 'Невозможно удалить уязвимость, так как она связана с зарегистрированным инцидентом';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER prevent_vulnerability_delete_trigger
    BEFORE DELETE ON vulnerability
    FOR EACH ROW
    EXECUTE FUNCTION prevent_vulnerability_delete_with_incidents();

CREATE OR REPLACE FUNCTION manage_incident_count()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        UPDATE info_asset
        SET incident_count = COALESCE(incident_count, 0) + 1
        WHERE id = NEW.id_info_asset;
        RETURN NEW;
        
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE info_asset
        SET incident_count = GREATEST(0, COALESCE(incident_count, 0) - 1)
        WHERE id = OLD.id_info_asset;
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_compromised_asset_changes
AFTER INSERT OR DELETE ON compromised_info_asset
FOR EACH ROW
EXECUTE FUNCTION manage_incident_count();

CREATE OR REPLACE FUNCTION check_owner_before_work()  -- 9
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'в работе' AND NEW.id_employee IS NULL THEN
        RAISE EXCEPTION 'Невозможно перевести инцидент в статус "в работе" без назначенного сотрудника';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER incidents_check_owner_before_work_trigger
BEFORE UPDATE ON incident
FOR EACH ROW
EXECUTE FUNCTION check_owner_before_work();

CREATE OR REPLACE FUNCTION update_incident_close_time()  -- 10
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'закрыт' THEN
        NEW.fixed_time := CURRENT_TIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER incident_close_trigger
BEFORE UPDATE ON incident
FOR EACH ROW
EXECUTE FUNCTION update_incident_close_time();
