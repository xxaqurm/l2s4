-- Триггер, автоматически изменяющий статус инцидента на «устранен» после
-- выполнения всех мероприятий по устранению
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

CREATE TRIGGER actions_aft_upd_resolve_incident_trigger
AFTER UPDATE ON remedial_measure
FOR EACH ROW
EXECUTE FUNCTION actions_aft_upd_resolve_incident();

CREATE OR REPLACE FUNCTION incidents_set_new_status_on_create()  -- 6
RETURNS TRIGGER AS $$
BEGIN
    NEW.status := 'новый';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER incidents_set_new_status_on_create_trigger
BEFORE INSERT ON incident
FOR EACH ROW
EXECUTE FUNCTION incidents_set_new_status_on_create();

CREATE OR REPLACE FUNCTION prevent_vulnerability_delete_with_incidents()  -- 7
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM exploited_vulnerability
        WHERE id_vulnerability = OLD.id
    ) THEN
        RAISE EXCEPTION 'Невозможно удалить уязвимость, так как она связана с существующими инцидентами';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_vulnerability_delete_trigger
BEFORE DELETE ON vulnerability
FOR EACH ROW
EXECUTE FUNCTION prevent_vulnerability_delete_with_incidents();

CREATE OR REPLACE FUNCTION check_owner_before_work()  -- 9
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'в работе' AND NEW.id_employee IS NULL THEN
        RAISE EXCEPTION 'Невозможно перевести инцидент в статус "в работе" без назначенного сотрудника';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER incidents_check_owner_before_work_trigger
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

CREATE TRIGGER incident_close_trigger
BEFORE UPDATE ON incident
FOR EACH ROW
EXECUTE FUNCTION update_incident_close_time();