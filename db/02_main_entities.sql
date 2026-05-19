-- Основные сущности

CREATE TABLE IF NOT EXISTS employee (  -- сотрудники
    id SERIAL PRIMARY KEY,
    
    id_departament INT REFERENCES departament(id) ON DELETE CASCADE,
    id_duty_roster INT REFERENCES duty_roster(id) ON DELETE CASCADE,

    first_name VARCHAR(20) NOT NULL,
    middle_name VARCHAR(20),
    last_name VARCHAR(20) NOT NULL,
    hire_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS vulnerability (  -- уязвимости
    id SERIAL PRIMARY KEY,

    id_risk_assessment INT NOT NULL REFERENCES risk_assessment(id) ON DELETE CASCADE,
    id_vulnerability_details INT NOT NULL REFERENCES vulnerability_details(id) ON DELETE CASCADE,

    name VARCHAR(50) NOT NULL,
    hack_type VARCHAR(50) NOT NULL,
    id_employee INT REFERENCES employee(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS info_asset (  -- информационные активы
    id SERIAL PRIMARY KEY,
    id_location INT NOT NULL REFERENCES location(id) ON DELETE CASCADE,

    name VARCHAR(50) NOT NULL,
    asset_type VARCHAR(50) NOT NULL,
    invent_number INT NOT NULL,
    count_of_incidents INT, 
    expl_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS asset_description (  -- характеристика актива
    id SERIAL PRIMARY KEY,
    id_info_asset INT NOT NULL REFERENCES info_asset(id) ON DELETE CASCADE,
    
    operating_system VARCHAR(50) NOT NULL,
    processor VARCHAR(50),
    ram_capacity VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS info_sec_measures (  -- средства защиты информации
    id SERIAL PRIMARY KEY,
    id_info_asset INT REFERENCES info_asset(id) ON DELETE CASCADE,

    name VARCHAR(50) NOT NULL,
    sec_type VARCHAR(100) NOT NULL,
    fstec_certificate VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS monitoring_tools (  -- инструменты мониторинга
    id SERIAL PRIMARY KEY,
    id_info_sec_measures INT NOT NULL REFERENCES info_sec_measures(id) ON DELETE CASCADE,

    collection_method VARCHAR(100) NOT NULL,
    collection_delay INT NOT NULL,
    agent_status VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS accounts (  -- учетные записи
    id SERIAL PRIMARY KEY,

    id_role INT NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    id_escalation_matrix INT NOT NULL REFERENCES escalation_matrix(id) ON DELETE CASCADE,
    id_access_perm INT NOT NULL REFERENCES access_permissions(id) ON DELETE CASCADE,
    id_employee INT NOT NULL REFERENCES employee(id) ON DELETE CASCADE,

    login VARCHAR(50) NOT NULL,
    password_hash VARCHAR(256) NOT NULL,
    date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    block_flag BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE IF NOT EXISTS incident (  -- инцидент
    id SERIAL PRIMARY KEY,

    id_sla INT REFERENCES sla(id) ON DELETE CASCADE,
    id_employee INT REFERENCES employee(id) ON DELETE CASCADE,

    title VARCHAR(50) NOT NULL,
    description VARCHAR(200) NOT NULL,
    detective_time TIMESTAMP NOT NULL,
    fixed_time TIMESTAMP,
    status VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS remedial_measure (  -- мера устранения
    id SERIAL PRIMARY KEY,

    id_incident INT NOT NULL REFERENCES incident(id) ON DELETE CASCADE,
    id_access_perm INT REFERENCES access_permissions(id) ON DELETE CASCADE,

    title VARCHAR(50),
    description VARCHAR(200),
    average_actions INT,
    exec_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS playbook (  -- playbook
    id SERIAL PRIMARY KEY,
    id_remedial_measure INT NOT NULL REFERENCES remedial_measure(id) ON DELETE CASCADE,

    title VARCHAR(50) NOT NULL,
    description VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS digital_artifacts (  -- цифровые артефакты
    id SERIAL PRIMARY KEY,
    id_incident INT REFERENCES incident(id) ON DELETE CASCADE,

    artifact_type VARCHAR(50) NOT NULL,
    hash_sum VARCHAR(256) NOT NULL
);

CREATE TABLE IF NOT EXISTS log_files (  -- журнал логов
    id SERIAL PRIMARY KEY,

    id_incident INT NOT NULL REFERENCES incident(id) ON DELETE CASCADE,
    id_account INT NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,

    event_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    event_type VARCHAR(50) NOT NULL,
    description VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS incident_source (  -- источник инцидента
    id SERIAL PRIMARY KEY,

    id_source_type INT NOT NULL REFERENCES source_type(id) ON DELETE CASCADE,
    id_incident INT REFERENCES incident(id) ON DELETE CASCADE,

    indentified_date TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS severity_level (  -- уровень критичности
    id SERIAL PRIMARY KEY,

    id_incident INT NOT NULL REFERENCES incident(id) ON DELETE CASCADE,
    id_damage INT NOT NULL REFERENCES financial_loss(id) ON DELETE CASCADE,
    id_escalation_matrix INT NOT NULL REFERENCES escalation_matrix(id) ON DELETE CASCADE,

    sev_level INT NOT NULL
);
