-- таблицы связец и журналы
CREATE TABLE IF NOT EXISTS mapping_mitre (  -- маппинг MITRE
    id SERIAL PRIMARY KEY,

    id_tactic INT NOT NULL REFERENCES tactics(id) ON DELETE CASCADE,
    id_technique INT NOT NULL REFERENCES techniques(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS techniques_used (  -- используемые техники
    id SERIAL PRIMARY KEY,

    id_technique INT NOT NULL REFERENCES techniques(id) ON DELETE CASCADE,
    id_vulnerability INT NOT NULL REFERENCES vulnerability(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS fixed_vulnerabilities (  -- исправленные уязвимости
    id SERIAL PRIMARY KEY,
    
    id_vulnerability INT NOT NULL REFERENCES vulnerability(id) ON DELETE CASCADE,
    id_patch INT NOT NULL REFERENCES patching(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS installed_software (  -- установленное ПО
    id SERIAL PRIMARY KEY,

    id_info_asset INT NOT NULL REFERENCES info_asset(id) ON DELETE CASCADE,
    id_software INT NOT NULL REFERENCES software(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS vulnerability_info_asset (  -- уязвимости активов
    id SERIAL PRIMARY KEY,

    id_vulnerability INT NOT NULL REFERENCES vulnerability(id) ON DELETE CASCADE,
    id_info_asset INT NOT NULL REFERENCES info_asset(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS compromised_info_asset (  -- поврежденный информационный актив
    id SERIAL PRIMARY KEY,

    id_incident INT REFERENCES incident(id) ON DELETE CASCADE,
    id_info_asset INT NOT NULL REFERENCES info_asset(id) ON DELETE CASCADE,

    downtime INT NOT NULL,
    damage_type VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS assessment_result (  -- результаты оценки
    id SERIAL PRIMARY KEY,

    id_vulnerability INT NOT NULL REFERENCES vulnerability(id) ON DELETE CASCADE,
    id_assessment INT NOT NULL REFERENCES assessment(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS exploited_vulnerability (  -- эксплуатируемая уязвимсоть
    id SERIAL PRIMARY KEY,

    id_vulnerability INT NOT NULL REFERENCES vulnerability(id) ON DELETE CASCADE,
    id_incident INT REFERENCES incident(id) ON DELETE CASCADE,

    description VARCHAR(200)
);