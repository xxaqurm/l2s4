CREATE OR REPLACE FUNCTION get_high_crit_vuln() -- 1
RETURNS SETOF vulnerability AS $$
BEGIN
    RETURN QUERY
    SELECT v.*
    FROM vulnerability AS v
    JOIN risk_assessment AS ra ON v.id_risk_assessment = ra.id
    WHERE ra.final_grade >= 70;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION server_assets() -- 2
RETURNS SETOF info_asset AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM info_asset
    WHERE asset_type = 'сервер';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION inf_sec_staff() -- 3
RETURNS SETOF employee AS $$
BEGIN
    RETURN QUERY
    SELECT e.*
    FROM employee AS e 
    JOIN departament AS d ON e.id_departament = d.id 
    WHERE d.name = 'ИБ';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION not_closed_inc() -- 4
RETURNS SETOF incident AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM incident
    WHERE fixed_time IS NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION remed_meas_after_date(target_date TIMESTAMP) -- 5
RETURNS SETOF remedial_measure AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM remedial_measure
    WHERE exec_date > target_date;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION vuln_at_assets(target_info_asset INT) -- 6
RETURNS SETOF vulnerability AS $$
BEGIN
    RETURN QUERY
    SELECT v.*
    FROM vulnerability AS v
    JOIN vulnerability_info_asset AS via ON v.id = via.id_vulnerability
    WHERE via.id_info_asset = target_info_asset;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION target_threat_degree (target_th INT) -- 7
RETURNS SETOF vulnerability AS $$
BEGIN
    RETURN QUERY
    SELECT v.*
    FROM vulnerability v 
    JOIN assessment_result ar ON v.id = ar.id_vulnerability 
    JOIN risk_assessment ra ON ra.id = ar.id_assessment 
    WHERE ra.final_grade > target_th; 
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION inc_on_resp_staff (target_emp INT) -- 8
RETURNS SETOF incident AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM incident
    WHERE id_employee = target_emp;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION expl_date_assets (target_date TIMESTAMP) -- 9
RETURNS SETOF info_asset AS $$
BEGIN
    RETURN QUERY
    SELECT ia.*
    FROM info_asset ia
    WHERE ia.expl_date > target_date;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION no_empl_on_vuln () -- 10
RETURNS SETOF vulnerability AS $$
BEGIN
    RETURN QUERY
    SELECT vuln.*
    FROM vulnerability vuln
    WHERE vuln.id_employee IS NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION high_crit_than_avg () -- 11
RETURNS SETOF vulnerability AS $$
BEGIN
    RETURN QUERY
    SELECT v.*
    FROM vulnerability v
    JOIN assessment_result ar ON v.id = ar.id_vulnerability
    JOIN risk_assessment ra ON ra.id = ar.id_assessment
    WHERE ra.final_grade > (SELECT AVG(final_grade) FROM risk_assessment);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION empl_on_inc_than_avg () -- 12
RETURNS SETOF employee AS $$
BEGIN
    RETURN QUERY
    SELECT emp.*
    FROM employee emp
    JOIN incident inc ON emp.id = inc.id_employee
    GROUP BY emp.id
    HAVING COUNT(inc.id) > (
        SELECT AVG(inc_count)
        FROM (
            SELECT COUNT(*) as inc_count
            FROM incident
            WHERE id_employee IS NOT NULL
            GROUP BY id_employee
        ) as subquery
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION assets_on_inc_than_avg () -- 13
RETURNS SETOF info_asset AS $$
BEGIN
    RETURN QUERY
    SELECT ia.*
    FROM info_asset ia
    JOIN compromised_info_asset cia ON ia.id = cia.id_info_asset
    JOIN incident inc ON inc.id = cia.id_incident
    GROUP BY ia.id
    HAVING COUNT(inc.id) > (
        SELECT AVG(inc_count)
        FROM (
            SELECT COUNT(*) as inc_count
            FROM compromised_info_asset
            GROUP BY id_info_asset
        ) as subquery
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION hack_types_than_avg () -- 14
RETURNS SETOF VARCHAR AS $$
BEGIN
    RETURN QUERY
    SELECT vuln.hack_type
    FROM vulnerability vuln
    GROUP BY vuln.hack_type
    HAVING COUNT(vuln.id) > (
        SELECT AVG(type_count)
        FROM (
            SELECT COUNT(*) as type_count
            FROM vulnerability
            GROUP BY hack_type
        ) as subquery
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION high_crit_inc_with_vuln () -- 15
RETURNS SETOF incident AS $$
BEGIN
    RETURN QUERY
    SELECT inc.*
    FROM incident inc
    JOIN exploited_vulnerability ev ON inc.id = ev.id_incident
    JOIN vulnerability vuln ON vuln.id = ev.id_vulnerability
    JOIN risk_assessment ra ON ra.id = vuln.id_risk_assessment
    WHERE ra.final_grade = (SELECT MAX(final_grade) FROM risk_assessment);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION remed_meas_on_empl (target_dep INT) -- 16
RETURNS SETOF employee AS $$
BEGIN
    RETURN QUERY
    SELECT empl.*
    FROM employee empl
    JOIN incident inc ON inc.id_employee = empl.id
    JOIN remedial_measure rem_meas ON inc.id = rem_meas.id_incident
    GROUP BY empl.id
    HAVING COUNT(rem_meas.id) > ALL (
        SELECT AVG(meas_count)
        FROM (
            SELECT COUNT(rm.id) as meas_count
            FROM employee e
            JOIN incident i ON i.id_employee = e.id
            JOIN remedial_measure rm ON i.id = rm.id_incident
            WHERE e.id_departament = target_dep
            GROUP BY e.id
        ) as subquery
    );
END;
$$ LANGUAGE plpgsql; 

CREATE OR REPLACE FUNCTION vuln_at_assets_inc_in_work () -- 17
RETURNS SETOF vulnerability AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT vuln.*
    FROM vulnerability vuln
    JOIN vulnerability_info_asset via ON vuln.id = via.id_vulnerability
    JOIN exploited_vulnerability ev ON vuln.id = ev.id_vulnerability
    JOIN incident inc ON ev.id_incident = inc.id
    WHERE inc.status = 'in work' AND inc.fixed_time IS NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION vuln_on_assets_than_avg () -- 18
RETURNS SETOF info_asset AS $$
BEGIN
    RETURN QUERY
    SELECT ia.*
    FROM info_asset ia
    JOIN vulnerability_info_asset via ON ia.id = via.id_info_asset
    GROUP BY ia.id
    HAVING COUNT(via.id_vulnerability) > (
        SELECT AVG(vuln_count)
        FROM (
            SELECT COUNT(*) vuln_count
            FROM vulnerability_info_asset
            GROUP BY id_info_asset
        ) as subquery
    );
END;
$$ LANGUAGE plpgsql;  

CREATE OR REPLACE FUNCTION inc_date_than_avg (start_period TIMESTAMP, end_period TIMESTAMP) -- 19
RETURNS SETOF incident AS $$
BEGIN
    RETURN QUERY
    SELECT inc.*
    FROM incident inc
    WHERE inc.detective_time BETWEEN start_period AND end_period
    AND inc.detective_time > (
        SELECT TO_TIMESTAMP(AVG(EXTRACT(EPOCH FROM sub_inc.detective_time)))
        FROM incident sub_inc
        WHERE sub_inc.detective_time BETWEEN start_period AND end_period
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION empl_on_inc () -- 20
RETURNS SETOF emplyeee AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT empl.*
    FROM employee empl
    JOIN incident inc ON empl.id = inc.id_employee
    JOIN exploited_vulnerability ev ON inc.id = ev.id_incident
    WHERE ev.id_vulnerability IN (
        SELECT id_vulnerability
        FROM exploited_vulnerability
        GROUP BY id_vulnerability
        ORDER BY COUNT(*) DESC
        LIMIT 1
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION crit_vuln_than_avg () 
RETURNS SETOF vulnerability AS $$
BEGIN
    RETURN QUERY
    SELECT vul.*
    FROM vulnerability vul
    JOIN assessment_result ar ON vul.id = ar.id_vulnerability
    JOIN risk_assessment ra ON ra.id = ar.id_assessment 
    WHERE ra.final_grade > (SELECT AVG(final_grade) FROM risk_assessment);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION empl_inc_than_avg () -- 22
RETURNS SETOF employee AS $$
BEGIN
    RETURN QUERY
    SELECT emp.*
    FROM employee emp
    JOIN incident inc ON emp.id = inc.id_employee
    GROUP BY emp.id
    HAVING COUNT(inc.id) > (
        SELECT AVG(inc_count) 
        FROM (
            SELECT COUNT(*) as inc_count 
            FROM incident 
            WHERE id_employee IS NOT NULL 
            GROUP BY id_employee
        ) as subquery
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION assets_with_max_incidents () -- 23
RETURNS SETOF info_asset AS $$
BEGIN
    RETURN QUERY
    SELECT ia.*
    FROM info_asset ia
    JOIN compromised_info_asset cia ON ia.id = cia.id_info_asset
    GROUP BY ia.id
    HAVING COUNT(cia.id_incident) = (
        SELECT MAX(inc_count)
        FROM (
            SELECT COUNT(id_incident) as inc_count
            FROM compromised_info_asset
            GROUP BY id_info_asset
        ) as subquery
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION hack_types_freq () -- 24
RETURNS SETOF VARCHAR AS $$
BEGIN
    RETURN QUERY
    SELECT vuln.hack_type
    FROM exploited_vulnerability ev
    JOIN vulnerability vuln ON ev.id_vulnerability = vuln.id
    GROUP BY vuln.hack_type
    HAVING COUNT(ev.id) > (
        SELECT AVG(exploit_count)
        FROM (
            SELECT COUNT(sub_ev.id) as exploit_count
            FROM exploited_vulnerability sub_ev
            JOIN vulnerability sub_v ON sub_ev.id_vulnerability = sub_v.id
            GROUP BY sub_v.hack_type
        ) as subquery
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION max_crit_inc () -- 25
RETURNS SETOF incident AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT inc.*
    FROM incident inc
    JOIN exploited_vulnerability ev ON inc.id = ev.id_incident
    JOIN vulnerability vuln ON vuln.id = ev.id_vulnerability
    JOIN assessment_result ar ON vuln.id = ar.id_vulnerability
    JOIN risk_assessment ra ON ra.id = ar.id_assessment
    WHERE ra.final_grade = (SELECT MAX(final_grade) FROM risk_assessment);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION empl_remed_than_avg () -- 26
RETURNS SETOF employee AS $$
BEGIN
    RETURN QUERY
    SELECT emp.*
    FROM employee emp
    JOIN incident inc ON emp.id = inc.id_employee
    JOIN remedial_measure rm ON inc.id = rm.id_incident
    GROUP BY emp.id
    HAVING COUNT(rm.id) > (
        SELECT AVG(rm_count)
        FROM (
            SELECT COUNT(sub_rm.id) as rm_count
            FROM employee sub_emp
            JOIN incident sub_inc ON sub_emp.id = sub_inc.id_employee
            JOIN remedial_measure sub_rm ON sub_inc.id = sub_rm.id_incident
            GROUP BY sub_emp.id
        ) as subquery
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION assets_vuln_than_avg () -- 27
RETURNS SETOF info_asset AS $$
BEGIN
    RETURN QUERY
    SELECT ia.*
    FROM info_asset ia
    JOIN vulnerability_info_asset via ON ia.id = via.id_info_asset
    GROUP BY ia.id
    HAVING COUNT(via.id_vulnerability) > (
        SELECT AVG(v_count)
        FROM (
            SELECT COUNT(id_vulnerability) as v_count
            FROM vulnerability_info_asset
            GROUP BY id_info_asset
        ) as subquery
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION hack_types_after_avg_date (start_period TIMESTAMP, end_period TIMESTAMP) -- 28
RETURNS SETOF VARCHAR AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT vuln.hack_type
    FROM vulnerability vuln
    JOIN exploited_vulnerability ev ON vuln.id = ev.id_vulnerability
    JOIN incident inc ON ev.id_incident = inc.id
    WHERE inc.detective_time BETWEEN start_period AND end_period
      AND inc.detective_time > (
          SELECT TO_TIMESTAMP(AVG(EXTRACT(EPOCH FROM sub_inc.detective_time)))
          FROM incident sub_inc
          WHERE sub_inc.detective_time BETWEEN start_period AND end_period
      );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION employees_on_top_vuln () -- 29
RETURNS SETOF employee AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT emp.*
    FROM employee emp
    JOIN incident inc ON emp.id = inc.id_employee
    JOIN exploited_vulnerability ev ON inc.id = ev.id_incident
    WHERE ev.id_vulnerability IN (
        SELECT id_vulnerability
        FROM exploited_vulnerability
        GROUP BY id_vulnerability
        ORDER BY COUNT(*) DESC
        LIMIT 1
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION incidents_on_high_risk_assets () -- 30
RETURNS SETOF incident AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT inc.*
    FROM incident inc
    JOIN compromised_info_asset cia ON inc.id = cia.id_incident
    WHERE cia.id_info_asset IN (
        SELECT ia.id
        FROM info_asset ia
        LEFT JOIN vulnerability_info_asset via ON ia.id = via.id_info_asset
        LEFT JOIN compromised_info_asset cia_sub ON ia.id = cia_sub.id_info_asset
        GROUP BY ia.id
        HAVING COUNT(DISTINCT via.id_vulnerability) > (
            SELECT AVG(v_count)
            FROM (SELECT COUNT(id_vulnerability) as v_count FROM vulnerability_info_asset GROUP BY id_info_asset) as sub1
        )
        AND COUNT(DISTINCT cia_sub.id_incident) > (
            SELECT AVG(inc_count)
            FROM (SELECT COUNT(id_incident) as inc_count FROM compromised_info_asset GROUP BY id_info_asset) as sub2
        )
    );
END;
$$ LANGUAGE plpgsql;
