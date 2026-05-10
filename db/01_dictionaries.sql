-- Таблицы без FK
CREATE TABLE IF NOT EXISTS tactics (  -- тактики
    id SERIAL PRIMARY KEY,

    title VARCHAR(50) NOT NULL,
    update_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS techniques (  -- техники
    id SERIAL PRIMARY KEY,

    title VARCHAR(50) NOT NULL,
    source VARCHAR(30) NOT NULL,
    description VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS patching (  -- патчинг
    id SERIAL PRIMARY KEY,

    title VARCHAR(50) NOT NULL,
    corrections VARCHAR(200) NOT NULL,
    version VARCHAR(20) NOT NULL,
    release_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS software (  -- ПО
    id SERIAL PRIMARY KEY,
    
    title VARCHAR(50) NOT NULL,
    version VARCHAR(10) NOT NULL,
    manufacturer VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS location (  -- локация
    id SERIAL PRIMARY KEY,

    address VARCHAR(50) NOT NULL,
    office VARCHAR(50) NOT NULL,
    desktop INT NOT NULL
);

CREATE TABLE IF NOT EXISTS risk_assessment (  -- оценка рисков
    id SERIAL PRIMARY KEY,

    occurrence_probability INT NOT NULL,
    potentional_damage INT NOT NULL,
    final_grade INT NOT NULL
);

CREATE TABLE IF NOT EXISTS vulnerability_details (  -- детали уязвимости
    id SERIAL PRIMARY KEY,
    
    technical_description VARCHAR(200) NOT NULL,
    vulnerable_component VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS roles (  -- роли
    id SERIAL PRIMARY KEY,
    role VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS source_type (  -- тип источника
    id SERIAL PRIMARY KEY,
    
    title VARCHAR(50) NOT NULL,
    type VARCHAR(20) NOT NULL,
    operating_system VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS escalation_matrix (  -- матрица эскалации
    id SERIAL PRIMARY KEY,
    response_threshold VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS financial_loss (  -- финансовый ущерб
    id SERIAL PRIMARY KEY,
    direct_losses INT NOT NULL,
    indirect_losses INT NOT NULL,
    fine INT NOT NULL,
    currency CHAR(3) NOT NULL
);

CREATE TABLE IF NOT EXISTS departament (  -- подразделение
    id SERIAL PRIMARY KEY,
    
    address VARCHAR(50) NOT NULL,
    opening_time TIMESTAMP NOT NULL,
    closing_time TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS sla (  -- sla
    id SERIAL PRIMARY KEY,

    average_time_response TIMESTAMP NOT NULL,
    standart_time_response TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS duty_roster (  -- график дежурств
    id SERIAL PRIMARY KEY,

    shift_start TIMESTAMP NOT NULL,
    shift_end TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS access_permissions (  -- права доступа
    id SERIAL PRIMARY KEY,
    permission_level VARCHAR(20) NOT NULL
);