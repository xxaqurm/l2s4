-- CREATE TABLE IF NOT EXISTS tactics (  -- тактика
--     id SERIAL PRIMARY KEY,
--     tactics_name VARCHAR(20) NOT NULL
-- );

CREATE TABLE IF NOT EXISTS duty_roster (  -- график дежурств
    id SERIAL PRIMARY KEY,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS financial_loss (  -- финансовый ущерб
    id SERIAL PRIMARY KEY,
    direct_losses INT NOT NULL,
    indirect_losses INT NOT NULL,
    financial_penalty INT NOT NULL,
    currency VARCHAR(3) NOT NULL
);

CREATE TABLE IF NOT EXISTS roles (  -- роли
    id SERIAL PRIMARY KEY,
    role_name VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS escalation_matrix (  -- матрица эскалации
    id SERIAL PRIMARY KEY,
    threshold VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS access_rights (  -- права доступа
    id SERIAL PRIMARY KEY,
    access_level VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS risk_assessment (  -- оценка рисков
    id SERIAL PRIMARY KEY,
    probability_of_occurrence INT NOT NULL,
    potential_damage INT NOT NULL,
    final_damage_assessment INT NOT NULL
);

CREATE TABLE IF NOT EXISTS sla (  -- sla
    id SERIAL PRIMARY KEY,
    average_response_time TIMESTAMP NOT NULL,
    response_time TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS software_reference (  -- Справочник ПО
    id SERIAL PRIMARY KEY,
    software_name VARCHAR(40) NOT NULL,
    software_version VARCHAR(10) NOT NULL,
    vendor VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS location (  -- локация
    id SERIAL PRIMARY KEY,
    address VARCHAR(50) NOT NULL,
    office VARCHAR(50) NOT NULL,
    desk INT NOT NULL
);

CREATE TABLE IF NOT EXISTS department (  -- подразделение
    id SERIAL PRIMARY KEY,
    department_address VARCHAR(50) NOT NULL,
    department_open_time TIMESTAMP NOT NULL,
    department_close_time TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS source_type (  -- тип источника
    id SERIAL PRIMARY KEY,
    source_type_name VARCHAR(20) NOT NULL,
    source_kind VARCHAR(20) NOT NULL,
    operating_system VARCHAR(20) NOT NULL
);