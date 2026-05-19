CREATE OR REPLACE FUNCTION avg_incident_response_time(start_date TIMESTAMP, end_date TIMESTAMP) -- среднее время реакции на инциденты
RETURNS INTERVAL AS $$
DECLARE
    avg_response INTERVAL;
BEGIN
    SELECT AVG(fixed_time - detective_time)
    INTO avg_response
    FROM incident
    WHERE detective_time >= start_date 
    AND detective_time <= end_date
    AND fixed_time IS NOT NULL;
    
    RETURN COALESCE(avg_response, INTERVAL '0 seconds');
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION count_incidents_by_period(start_date TIMESTAMP, end_date TIMESTAMP) -- 2
RETURNS INTEGER AS $$
DECLARE
    incident_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO incident_count
    FROM incident
    WHERE detective_time >= start_date 
    AND detective_time <= end_date;
    
    RETURN incident_count;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION count_vuln_by_grade(target_grade INT) -- 3
RETURNS INTEGER AS $$
DECLARE
    vuln_count INTEGER;
BEGIN
    SELECT COUNT(v.id)
    INTO vuln_count
    FROM vulnerability v
    JOIN risk_assessment ra ON v.id_risk_assessment = ra.id
    WHERE ra.final_grade = target_grade;
    
    RETURN vuln_count;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_threat_for_incident(target_incident INT) -- 4
RETURNS BOOLEAN AS $$
DECLARE
    has_threat BOOLEAN;
BEGIN
    SELECT EXISTS(
        SELECT 1
        FROM severity_level
        WHERE id_incident = target_incident
    )
    INTO has_threat;
    
    RETURN has_threat;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION most_common_hack_type(start_date TIMESTAMP, end_date TIMESTAMP) -- 5
RETURNS VARCHAR AS $$
DECLARE
    common_type VARCHAR;
BEGIN
    SELECT hack_type
    INTO common_type
    FROM vulnerability
    WHERE id IN (
        SELECT v.id
        FROM vulnerability v
        JOIN exploited_vulnerability ev ON v.id = ev.id_vulnerability
        JOIN incident i ON ev.id_incident = i.id
        WHERE i.detective_time >= start_date 
        AND i.detective_time <= end_date
    )
    GROUP BY hack_type
    ORDER BY COUNT(*) DESC
    LIMIT 1;
    
    RETURN COALESCE(common_type, 'No data');
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION count_incidents_by_employee(target_emp INT) -- 6
RETURNS INTEGER AS $$
DECLARE
    emp_incident_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO emp_incident_count
    FROM incident
    WHERE id_employee = target_emp;
    
    RETURN emp_incident_count;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION assets_with_vulnerabilities() -- 7
RETURNS SETOF info_asset AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT ia.*
    FROM info_asset ia
    JOIN vulnerability_info_asset via ON ia.id = via.id_info_asset
    WHERE via.id_vulnerability IS NOT NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION count_open_incidents() -- 8
RETURNS INTEGER AS $$
DECLARE
    open_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO open_count
    FROM incident
    WHERE fixed_time IS NULL AND status = 'open';
    
    RETURN open_count;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION avg_vuln_per_asset() -- 9
RETURNS NUMERIC AS $$
DECLARE
    avg_vulnerabilities NUMERIC;
BEGIN
    SELECT AVG(vuln_count)
    INTO avg_vulnerabilities
    FROM (
        SELECT COUNT(via.id_vulnerability) as vuln_count
        FROM info_asset ia
        LEFT JOIN vulnerability_info_asset via ON ia.id = via.id_info_asset
        GROUP BY ia.id
    ) as subquery;
    
    RETURN ROUND(COALESCE(avg_vulnerabilities, 0), 2);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION staff_high_crit_incidents() -- 10
RETURNS SETOF employee AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT e.*
    FROM employee e
    JOIN incident i ON e.id = i.id_employee
    JOIN severity_level sl ON i.id = sl.id_incident
    WHERE sl.sev_level >= 8;
END;
$$ LANGUAGE plpgsql;
