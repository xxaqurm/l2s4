CREATE OR REPLACE FUNCTION set_reg_date() -- 1
RETURNS TRIGGER AS $$
BEGIN 
    NEW.reg_date = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_set_incident_reg_date
    BEFORE INSERT ON incidents
    FOR EACH ROW
    EXECUTE FUNCTION set_reg_date();

CREATE OR REPLACE FUNCTION check_severity_level() -- 2
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.sev_level < 0 OR NEW.sev_level > 100 THEN
    RAISE EXCEPTION 'Некорректный уровень критичности', NEW.sev_level;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_severity_level
    BEFORE INSERT ON severity_level
    FOR EACH ROW
    EXECUTE FUNCTION check_severity_level();

CREATE OR REPLACE FUNCTION lock_insert_without_source() -- 3
RETURNS TRIGGER AS $$
DECLARE
    source_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO source_count
    FROM incident_source
    WHERE id_incident = NEW.id;

    IF source_count = 0 THEN 
        RAISE EXCEPTION 'Нельзя добавить инцидент без источника', NEW.id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE CONSTRAINT TRIGGER trigger_lock_insert_without_source
    AFTER INSERT ON incident
    DEFERRABLE INITIALLY DEFERRED
    FOR EACH ROW
    EXECUTE FUNCTION lock_insert_without_source();

CREATE OR REPLACE FUNCTION incident_status_change()
RETURNS TRIGGER AS $$
BEGIN
    