-- Тестовые данные для БД lab2

INSERT INTO departament (name, address, opening_time, closing_time) VALUES
('ИБ', 'ул. Ленина, 10', '2024-01-01 09:00:00', '2024-01-01 18:00:00'),
('Разработка', 'ул. Ленина, 10', '2024-01-01 10:00:00', '2024-01-01 19:00:00'),
('Администрирование', 'ул. Ленина, 10', '2024-01-01 08:00:00', '2024-01-01 20:00:00');

INSERT INTO duty_roster (shift_start, shift_end) VALUES
('2024-01-01 09:00:00', '2024-01-01 18:00:00'),
('2024-01-01 18:00:00', '2024-01-02 09:00:00'),
('2024-01-01 10:00:00', '2024-01-01 19:00:00');

INSERT INTO location (address, office, desktop) VALUES
('ул. Ленина, 10', 'Офис 101', 1),
('ул. Ленина, 10', 'Офис 102', 2),
('ул. Ленина, 10', 'Серверная', 1);

INSERT INTO roles (role) VALUES
('admin'),
('user'),
('analyst');

INSERT INTO access_permissions (permission_level) VALUES
('full_access'),
('read_only'),
('analyst_access');

INSERT INTO escalation_matrix (response_threshold) VALUES
('critical'),
('high'),
('medium');

INSERT INTO financial_loss (direct_losses, indirect_losses, fine, currency) VALUES
(100000, 50000, 25000, 'RUB'),
(500000, 200000, 100000, 'RUB'),
(1000000, 500000, 250000, 'RUB');

INSERT INTO sla (average_time_response, standart_time_response) VALUES
('2024-01-01 01:00:00', '2024-01-01 02:00:00'),
('2024-01-01 04:00:00', '2024-01-01 08:00:00');

INSERT INTO source_type (title, type, operating_system) VALUES
('Email', 'external', 'Windows'),
('Network', 'internal', 'Linux'),
('User Report', 'internal', 'Mixed');

INSERT INTO tactics (title, description) VALUES
('Initial Access', 'Techniques used to gain initial access'),
('Execution', 'Techniques used to run code'),
('Persistence', 'Techniques used to maintain access');

INSERT INTO techniques (title, source, description) VALUES
('Spearphishing Attachment', 'MITRE', 'Sending malicious email'),
('Command Line Interface', 'MITRE', 'Using CLI for execution'),
('Registry Run Keys', 'MITRE', 'Persistence through registry');

INSERT INTO patching (title, corrections, version, release_date) VALUES
('Security Update KB123456', 'Fixed SQL Injection', '1.0.1', NOW()),
('Critical Patch MS2024', 'Fixed RCE vulnerability', '2.0.0', NOW() - INTERVAL '7 days');

INSERT INTO software (title, version, manufacturer) VALUES
('Windows Server', '2022', 'Microsoft'),
('Linux Kernel', '5.15', 'Linux Foundation'),
('Apache', '2.4.52', 'Apache Software Foundation');

INSERT INTO vulnerability_details (technical_description, vulnerable_component) VALUES
('SQL Injection in login form', 'Authentication Module'),
('Command Injection in file upload', 'File Processing'),
('Path Traversal in file access', 'File Storage');

INSERT INTO risk_assessment (occurrence_probability, potentional_damage) VALUES
(7, 10),
(8, 9),
(5, 6),
(10, 10),
(3, 4);

INSERT INTO employee (id_departament, id_duty_roster, first_name, middle_name, last_name) VALUES
(1, 1, 'Иван', 'Иванович', 'Иванов'),
(1, 2, 'Петр', 'Петрович', 'Петров'),
(2, 1, 'Сергей', 'Сергеевич', 'Сергеев'),
(3, 1, 'Михаил', 'Михайлович', 'Михайлов'),
(1, 1, 'Анна', 'Александровна', 'Смирнова'),
(2, 2, 'Елена', 'Вячеславовна', 'Волкова');

INSERT INTO vulnerability (id_risk_assessment, id_vulnerability_details, name, hack_type, id_employee) VALUES
(1, 1, 'SQL Injection in Auth', 'Injection', 1),
(2, 2, 'Command Injection', 'Injection', NULL),
(3, 3, 'Path Traversal', 'Directory Traversal', 1),
(4, 1, 'Critical SQL Vuln', 'Injection', 2),
(5, 2, 'Low Priority Vuln', 'Injection', NULL);

INSERT INTO info_asset (id_location, name, asset_type, invent_number, expl_date) VALUES
(1, 'WEB-Server-01', 'сервер', 1001, NOW() - INTERVAL '365 days'),
(1, 'DB-Server-01', 'сервер', 1002, NOW() - INTERVAL '180 days'),
(2, 'WorkStation-01', 'рабочая станция', 2001, NOW() - INTERVAL '30 days'),
(3, 'Backup-Server', 'сервер', 1003, NOW() - INTERVAL '90 days');

INSERT INTO asset_description (id_info_asset, operating_system, processor, ram_capacity) VALUES
(1, 'Linux Ubuntu 22.04', 'Intel Xeon', '32GB'),
(2, 'Linux CentOS 8', 'Intel Xeon', '64GB'),
(3, 'Windows 10', 'Intel i7', '16GB'),
(4, 'Linux Debian 11', 'Intel Xeon', '16GB');

INSERT INTO info_sec_measures (id_info_asset, name, sec_type, fstec_certificate) VALUES
(1, 'WAF-Mod-Security', 'Web Application Firewall', 'FSTEC-2023-001'),
(2, 'Encryption at Rest', 'Data Encryption', 'FSTEC-2023-002'),
(3, 'EDR Solution', 'Endpoint Detection', 'FSTEC-2023-003');

INSERT INTO monitoring_tools (id_info_sec_measures, collection_method, collection_delay, agent_status) VALUES
(1, 'HTTP Traffic Analysis', 30, 'active'),
(2, 'File System Events', 60, 'active'),
(3, 'Process Monitoring', 5, 'inactive');

INSERT INTO accounts (id_role, id_escalation_matrix, id_access_perm, id_employee, login, password_hash, block_flag) VALUES
(1, 1, 1, 1, 'ivanov_i', 'hash_here_1', false),
(2, 2, 2, 2, 'petrov_p', 'hash_here_2', false),
(2, 2, 2, 3, 'sergeev_s', 'hash_here_3', false),
(1, 1, 1, 4, 'mikhailov_m', 'hash_here_4', true),
(2, 2, 2, 5, 'smirnova_a', 'hash_here_5', false),
(1, 1, 1, 6, 'volkova_e', 'hash_here_6', false);

INSERT INTO incident (id_sla, id_employee, title, description, detective_time, fixed_time, status) VALUES
(1, 1, 'Инцидент 1', 'Попытка SQL injection', NOW() - INTERVAL '10 days', NOW() - INTERVAL '5 days', 'resolved'),
(1, 2, 'Инцидент 2', 'Несанкционированный доступ', NOW() - INTERVAL '20 days', NULL, 'open'),
(2, 3, 'Инцидент 3', 'Утечка данных', NOW() - INTERVAL '2 days', NOW(), 'resolved'),
(1, 1, 'Инцидент 4', 'DDoS атака', NOW() - INTERVAL '15 days', NULL, 'open'),
(2, 4, 'Инцидент 5', 'Фишинг', NOW() - INTERVAL '8 days', NOW() - INTERVAL '3 days', 'resolved'),
(1, 5, 'Инцидент 6', 'Вредоносное ПО', NOW() - INTERVAL '12 days', NULL, 'in work');

INSERT INTO remedial_measure (id_incident, id_access_perm, title, description, average_actions, exec_date) VALUES
(1, 1, 'Patch SQL Vuln', 'Обновление базы данных', 5, NOW() - INTERVAL '5 days'),
(2, 2, 'Access Review', 'Проверка прав доступа', 3, NOW() - INTERVAL '10 days'),
(3, 1, 'Security Hardening', 'Усиление безопасности', 8, NOW()),
(4, 1, 'Network Isolation', 'Изоляция сети', 10, NOW() - INTERVAL '14 days'),
(5, 2, 'Email Filter Update', 'Обновление фильтров', 2, NOW() - INTERVAL '3 days'),
(6, 1, 'Antivirus Scan', 'Полное сканирование', 6, NULL);

INSERT INTO playbook (id_remedial_measure, title, description) VALUES
(1, 'SQL Injection Response', 'Действия при SQL injection'),
(2, 'Access Control Review', 'Проверка управления доступом'),
(3, 'Security Hardening Steps', 'Шаги усиления безопасности'),
(4, 'DDoS Mitigation', 'Митигация DDoS атак'),
(5, 'Phishing Response', 'Ответ на фишинг');

INSERT INTO digital_artifacts (id_incident, artifact_type, hash_sum) VALUES
(1, 'malware_sample', 'a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6'),
(2, 'log_file', 'f1e2d3c4b5a6g7h8i9j0k1l2m3n4o5p6'),
(3, 'network_pcap', 'c1b2a3f4e5d6g7h8i9j0k1l2m3n4o5p6'),
(4, 'traffic_dump', 'd2e3f4a5b6c7g8h9i0j1k2l3m4n5o6p7'),
(5, 'email_message', 'e3f4a5b6c7d8g9h0i1j2k3l4m5n6o7p8'),
(6, 'infected_file', 'f4a5b6c7d8e9g0h1i2j3k4l5m6n7o8p9');

INSERT INTO log_files (id_incident, id_account, event_type, description) VALUES
(1, 1, 'SQL_INJECTION_ATTEMPT', 'Обнаружена попытка SQL injection'),
(2, 2, 'UNAUTHORIZED_ACCESS', 'Несанкционированная попытка доступа'),
(3, 3, 'DATA_EXFILTRATION', 'Попытка утечки данных'),
(4, 1, 'DDOS_ATTACK', 'DDoS атака обнаружена'),
(5, 2, 'PHISHING_EMAIL', 'Фишинг письмо получено'),
(6, 3, 'MALWARE_DETECTED', 'Обнаружено вредоносное ПО');

INSERT INTO incident_source (id_source_type, id_incident, indentified_date) VALUES
(1, 1, NOW() - INTERVAL '10 days'),
(2, 2, NOW() - INTERVAL '20 days'),
(3, 3, NOW() - INTERVAL '2 days'),
(2, 4, NOW() - INTERVAL '15 days'),
(1, 5, NOW() - INTERVAL '8 days'),
(3, 6, NOW() - INTERVAL '12 days');

INSERT INTO severity_level (id_incident, id_damage, id_escalation_matrix, sev_level) VALUES
(1, 1, 1, 8),
(2, 2, 2, 9),
(3, 3, 1, 7),
(4, 1, 2, 10),
(5, 2, 1, 6),
(6, 3, 2, 8);

INSERT INTO vulnerability_info_asset (id_vulnerability, id_info_asset) VALUES
(1, 1),
(1, 3),
(2, 1),
(3, 2),
(4, 1),
(5, 3);

INSERT INTO compromised_info_asset (id_incident, id_info_asset, downtime, damage_type) VALUES
(1, 1, 120, 'data_loss'),
(2, 1, 240, 'data_exposure'),
(3, 2, 60, 'downtime'),
(4, 1, 480, 'performance_degradation'),
(5, 3, 30, 'infection'),
(6, 2, 90, 'compromise');

INSERT INTO assessment_result (id_vulnerability, id_assessment) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO exploited_vulnerability (id_vulnerability, id_incident, description) VALUES
(1, 1, 'Успешная эксплуатация SQL injection'),
(2, 2, 'Использование команды для доступа'),
(4, 4, 'Критическая уязвимость эксплуатирована'),
(3, 5, 'Path traversal в системе');


INSERT INTO mapping_mitre (id_tactic, id_technique) VALUES
(1, 1),
(2, 2),
(3, 3),
(1, 2),
(2, 3);

INSERT INTO techniques_used (id_technique, id_vulnerability) VALUES
(1, 1),
(2, 2),
(3, 3),
(1, 4),
(2, 5);

INSERT INTO fixed_vulnerabilities (id_vulnerability, id_patch) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 2);

INSERT INTO installed_software (id_info_asset, id_software) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(1, 2);
