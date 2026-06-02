-- тестовые данные

-- Departments (различные подразделения)
INSERT INTO departament (name, address, opening_time, closing_time) VALUES
('ИБ', 'ул. Ленина, 10, офис 1', '2024-01-01 09:00:00', '2024-01-01 18:00:00'),
('Разработка', 'ул. Ленина, 10, офис 2', '2024-01-01 10:00:00', '2024-01-01 19:00:00'),
('Администрирование', 'ул. Ленина, 10, офис 3', '2024-01-01 08:00:00', '2024-01-01 20:00:00'),
('DevOps', 'ул. Ленина, 10, офис 4', '2024-01-01 08:00:00', '2024-01-01 17:00:00'),
('Поддержка', 'ул. Ленина, 10, офис 5', '2024-01-01 08:00:00', '2024-01-01 21:00:00'),
('Тестирование', 'ул. Ленина, 10, офис 6', '2024-01-01 09:00:00', '2024-01-01 18:00:00');

-- Duty rosters (графики дежурств)
INSERT INTO duty_roster (shift_start, shift_end) VALUES
('2024-01-01 09:00:00', '2024-01-01 18:00:00'),
('2024-01-01 18:00:00', '2024-01-02 09:00:00'),
('2024-01-01 10:00:00', '2024-01-01 19:00:00'),
('2024-01-01 08:00:00', '2024-01-01 17:00:00'),
('2024-01-01 17:00:00', '2024-01-02 02:00:00');

-- Locations (локации активов)
INSERT INTO location (address, office, desktop) VALUES
('ул. Ленина, 10', 'Офис 101', 1),
('ул. Ленина, 10', 'Офис 101', 2),
('ул. Ленина, 10', 'Офис 102', 1),
('ул. Ленина, 10', 'Офис 102', 2),
('ул. Ленина, 10', 'Серверная 1', 1),
('ул. Ленина, 10', 'Серверная 1', 2),
('ул. Красина, 50', 'Офис 201', 1),
('ул. Красина, 50', 'Серверная 2', 1);

-- Roles (роли пользователей)
INSERT INTO roles (role) VALUES
('admin'),
('security_analyst'),
('system_admin'),
('developer'),
('user'),
('ciso'),
('incident_responder');

-- Access permissions (уровни доступа)
INSERT INTO access_permissions (permission_level) VALUES
('full_access'),
('read_write'),
('read_only'),
('analyst_access'),
('developer_access'),
('restricted_access');

-- Escalation matrix (матрица эскалации)
INSERT INTO escalation_matrix (response_threshold) VALUES
('critical'),
('high'),
('medium'),
('low'),
('info');

-- Financial loss categories (финансовые категории потерь)
INSERT INTO financial_loss (direct_losses, indirect_losses, fine, currency) VALUES
(50000, 25000, 10000, 'RUB'),
(100000, 50000, 25000, 'RUB'),
(500000, 200000, 100000, 'RUB'),
(1000000, 500000, 250000, 'RUB'),
(5000000, 2000000, 1000000, 'RUB'),
(10000, 5000, 2000, 'RUB'),
(200000, 100000, 50000, 'RUB');

-- SLA (SLA соглашения)
INSERT INTO sla (average_time_response, standart_time_response) VALUES
('2024-01-01 01:00:00', '2024-01-01 02:00:00'),
('2024-01-01 04:00:00', '2024-01-01 08:00:00'),
('2024-01-01 00:30:00', '2024-01-01 01:00:00'),
('2024-01-01 24:00:00', '2024-01-02 00:00:00');

-- Source types (типы источников инцидентов)
INSERT INTO source_type (title, type, operating_system) VALUES
('Email', 'external', 'Windows'),
('Network Monitor', 'internal', 'Linux'),
('User Report', 'internal', 'Mixed'),
('IDS Alert', 'internal', 'Linux'),
('WAF Alert', 'internal', 'Linux'),
('EDR Alert', 'internal', 'Windows'),
('Log Analysis', 'internal', 'Linux'),
('Third Party', 'external', 'Unknown');

-- MITRE Tactics (MITRE ATT&CK тактики)
INSERT INTO tactics (title, description) VALUES
('Initial Access', 'Techniques used to gain initial access to target systems'),
('Execution', 'Techniques used to run code on target systems'),
('Persistence', 'Techniques used to maintain access to target systems'),
('Privilege Escalation', 'Techniques used to increase privilege levels'),
('Defense Evasion', 'Techniques used to evade defensive systems'),
('Credential Access', 'Techniques used to obtain credentials'),
('Discovery', 'Techniques used to reconnaissance target environments'),
('Lateral Movement', 'Techniques used to move through networks'),
('Collection', 'Techniques used to gather data'),
('Exfiltration', 'Techniques used to steal data');

-- MITRE Techniques (MITRE ATT&CK техники)
INSERT INTO techniques (title, source, description) VALUES
('Spearphishing Attachment', 'MITRE', 'Deliver malicious attachment via email'),
('Spearphishing Link', 'MITRE', 'Deliver phishing link via email'),
('Command Line Interface', 'MITRE', 'Execute commands via CLI'),
('PowerShell', 'MITRE', 'Execute commands via PowerShell'),
('Registry Run Keys', 'MITRE', 'Persistence through Windows registry'),
('Scheduled Task', 'MITRE', 'Create scheduled task for persistence'),
('Sudo', 'MITRE', 'Privilege escalation using sudo'),
('SUID', 'MITRE', 'Privilege escalation using SUID binaries'),
('OS Credential Dumping', 'MITRE', 'Dump credentials from operating system'),
('Input Capture', 'MITRE', 'Capture keyboard input'),
('Network Service Scanning', 'MITRE', 'Scan network for active services'),
('System Information Discovery', 'MITRE', 'Gather system information'),
('Lateral Tool Transfer', 'MITRE', 'Transfer tools to other systems'),
('File Staging', 'MITRE', 'Stage files for exfiltration'),
('Data Transfer Size Limits', 'MITRE', 'Exfiltrate data in small portions');

-- Patches (патчи и обновления)
INSERT INTO patching (title, corrections, version, release_date) VALUES
('Security Update KB123456', 'Fixed SQL Injection in authentication', '1.0.1', NOW()),
('Critical Patch MS2024-01', 'Fixed RCE vulnerability in kernel', '2.0.0', NOW() - INTERVAL '7 days'),
('Hotfix for CVE-2024-1234', 'Patched path traversal vulnerability', '1.5.2', NOW() - INTERVAL '14 days'),
('Security Update KB789012', 'Fixed privilege escalation in sudo', '3.1.0', NOW() - INTERVAL '21 days'),
('Emergency Patch', 'Fixed critical zero-day', '2.1.0', NOW() - INTERVAL '1 day'),
('Regular Update', 'Regular security updates', '4.0.0', NOW() - INTERVAL '30 days');

-- Software (программное обеспечение)
INSERT INTO software (title, version, manufacturer) VALUES
('Windows Server', '2022', 'Microsoft'),
('Windows 10', '22H2', 'Microsoft'),
('Linux Kernel', '5.15', 'Linux Foundation'),
('Apache', '2.4.52', 'Apache Software Foundation'),
('Nginx', '1.24', 'Nginx Inc'),
('PostgreSQL', '14.5', 'PostgreSQL Global Development Group'),
('MySQL', '8.0.35', 'Oracle'),
('Docker', '24.0', 'Docker Inc'),
('Kubernetes', '1.28', 'Cloud Native Computing Foundation'),
('OpenSSH', '8.6', 'OpenBSD'),
('OpenSSL', '3.0', 'OpenSSL Project');

-- Vulnerability Details (детали уязвимостей)
INSERT INTO vulnerability_details (technical_description, vulnerable_component) VALUES
('SQL Injection in login form allows database manipulation', 'Authentication Module'),
('Command Injection in file upload allows arbitrary code execution', 'File Processing Module'),
('Path Traversal in file access allows unauthorized file access', 'File Storage Module'),
('Cross-Site Scripting in user profile allows session hijacking', 'Web Interface'),
('Buffer Overflow in image processing allows RCE', 'Image Library'),
('Weak SSH key generation allows brute force attacks', 'SSH Service'),
('Unvalidated redirects allow phishing attacks', 'Web Application'),
('Missing authentication on API endpoints exposes data', 'REST API'),
('Insecure deserialization allows code execution', 'Data Processing'),
('Hardcoded credentials found in source code', 'Configuration'),
('XXE vulnerability in XML parser allows data exfiltration', 'XML Processor'),
('LDAP Injection in authentication bypass possible', 'LDAP Integration');

-- Risk Assessment (оценки рисков)
INSERT INTO risk_assessment (occurrence_probability, potentional_damage) VALUES
(7, 10),  -- High probability, critical damage
(8, 9),   -- Very high probability, critical damage
(5, 6),   -- Medium probability, moderate damage
(10, 10), -- Certain, catastrophic damage
(3, 4),   -- Low probability, minor damage
(6, 8),   -- Medium-high probability, high damage
(9, 7),   -- Very high probability, high damage
(2, 3),   -- Very low probability, minimal damage
(4, 5),   -- Low probability, low-medium damage
(10, 8);  -- Certain, high damage

-- Employees (сотрудники)
INSERT INTO employee (id_departament, id_duty_roster, first_name, middle_name, last_name) VALUES
(1, 1, 'Иван', 'Иванович', 'Иванов'),          -- Security lead
(1, 2, 'Петр', 'Петрович', 'Петров'),          -- Security analyst
(2, 1, 'Сергей', 'Сергеевич', 'Сергеев'),      -- Developer
(3, 1, 'Михаил', 'Михайлович', 'Михайлов'),    -- System admin
(1, 1, 'Анна', 'Александровна', 'Смирнова'),   -- Security analyst
(2, 2, 'Елена', 'Вячеславовна', 'Волкова'),    -- Developer
(3, 4, 'Алексей', 'Алексеевич', 'Орлов'),      -- System admin
(4, 5, 'Юлия', 'Юрьевна', 'Кузнецова'),       -- DevOps engineer
(5, 1, 'Владимир', 'Владимирович', 'Новиков'), -- Support engineer
(1, 3, 'Ольга', 'Олеговна', 'Соколова'),       -- Security analyst
(6, 1, 'Андрей', 'Андреевич', 'Лебедев'),      -- QA engineer
(2, 2, 'Татьяна', 'Борисовна', 'Павлова');     -- Senior developer

-- Information Assets (информационные активы)
INSERT INTO info_asset (id_location, name, asset_type, invent_number, expl_date) VALUES
(1, 'WEB-Server-01', 'сервер', 1001, NOW() - INTERVAL '365 days'),
(1, 'WEB-Server-02', 'сервер', 1002, NOW() - INTERVAL '340 days'),
(2, 'DB-Server-01', 'сервер', 1003, NOW() - INTERVAL '180 days'),
(2, 'DB-Server-02', 'сервер', 1004, NOW() - INTERVAL '175 days'),
(3, 'WorkStation-01', 'рабочая станция', 2001, NOW() - INTERVAL '30 days'),
(3, 'WorkStation-02', 'рабочая станция', 2002, NOW() - INTERVAL '28 days'),
(4, 'WorkStation-03', 'рабочая станция', 2003, NOW() - INTERVAL '45 days'),
(5, 'Backup-Server', 'сервер', 1005, NOW() - INTERVAL '90 days'),
(5, 'Mail-Server', 'сервер', 1006, NOW() - INTERVAL '120 days'),
(6, 'DNS-Server', 'сервер', 1007, NOW() - INTERVAL '60 days'),
(7, 'Laptop-Dev-01', 'ноутбук', 3001, NOW() - INTERVAL '15 days'),
(8, 'Storage-System', 'сервер', 1008, NOW() - INTERVAL '200 days');

-- Asset Descriptions (описания активов)
INSERT INTO asset_description (id_info_asset, operating_system, processor, ram_capacity) VALUES
(1, 'Linux Ubuntu 22.04', 'Intel Xeon E5-2690', '32GB'),
(2, 'Linux Ubuntu 22.04', 'Intel Xeon E5-2690', '32GB'),
(3, 'Linux CentOS 8', 'Intel Xeon E7-4850', '64GB'),
(4, 'Linux CentOS 8', 'Intel Xeon E7-4850', '64GB'),
(5, 'Windows 10', 'Intel i7-10700K', '16GB'),
(6, 'Windows 10', 'Intel i7-10700K', '16GB'),
(7, 'Windows 11', 'Intel i9-12900', '32GB'),
(8, 'Linux Debian 11', 'Intel Xeon E5-2680', '128GB'),
(9, 'Linux Ubuntu 20.04', 'Intel Xeon E5-2670', '16GB'),
(10, 'Linux Alpine 3.17', 'Intel Xeon', '4GB'),
(11, 'Windows 11', 'Intel i7-12700H', '16GB'),
(12, 'Linux RedHat 9', 'Intel Xeon Platinum', '96GB');

-- Information Security Measures (средства защиты информации)
INSERT INTO info_sec_measures (id_info_asset, name, sec_type, fstec_certificate) VALUES
(1, 'WAF-ModSecurity', 'Web Application Firewall', 'FSTEC-2023-001'),
(1, 'SSL/TLS Termination', 'Encryption in Transit', 'FSTEC-2023-005'),
(2, 'WAF-ModSecurity', 'Web Application Firewall', 'FSTEC-2023-001'),
(3, 'Transparent Data Encryption', 'Data Encryption', 'FSTEC-2023-002'),
(4, 'Transparent Data Encryption', 'Data Encryption', 'FSTEC-2023-002'),
(5, 'EDR Solution', 'Endpoint Detection and Response', 'FSTEC-2023-003'),
(6, 'EDR Solution', 'Endpoint Detection and Response', 'FSTEC-2023-003'),
(8, 'Incremental Backup Encryption', 'Backup Protection', 'FSTEC-2023-004'),
(9, 'Email Encryption', 'Email Security', 'FSTEC-2023-006'),
(10, 'DNSSEC', 'DNS Security', 'FSTEC-2023-007'),
(11, 'Full Disk Encryption', 'Endpoint Protection', 'FSTEC-2023-003'),
(12, 'Data Replication Encryption', 'Storage Security', 'FSTEC-2023-008');

-- Monitoring Tools (инструменты мониторинга)
INSERT INTO monitoring_tools (id_info_sec_measures, collection_method, collection_delay, agent_status) VALUES
(1, 'HTTP Traffic Analysis Deep Inspection', 30, 'active'),
(2, 'SSL Certificate Monitoring', 3600, 'active'),
(3, 'HTTP Traffic Analysis Deep Inspection', 30, 'active'),
(4, 'File System Events and Queries', 60, 'active'),
(5, 'File System Events and Queries', 60, 'active'),
(6, 'Process Monitoring and API Hooking', 5, 'active'),
(7, 'Process Monitoring and API Hooking', 5, 'inactive'),
(8, 'Backup Job Monitoring', 120, 'active'),
(9, 'Email Gateway Logs', 300, 'active'),
(10, 'DNS Query Logging', 10, 'active'),
(11, 'File Access and Modification Events', 15, 'active'),
(12, 'Replication Status Monitoring', 1800, 'active');

-- Accounts (учетные записи)
INSERT INTO accounts (id_role, id_escalation_matrix, id_access_perm, id_employee, login, password_hash, block_flag) VALUES
(1, 1, 1, 1, 'ivanov_i', 'bcrypt_hash_level_10_1a2b3c4d5e6f', false),
(3, 2, 2, 2, 'petrov_p', 'bcrypt_hash_level_10_2a3b4c5d6e7f', false),
(4, 3, 5, 3, 'sergeev_s', 'bcrypt_hash_level_10_3a4b5c6d7e8f', false),
(3, 2, 2, 4, 'mikhailov_m', 'bcrypt_hash_level_10_4a5b6c7d8e9f', true),
(2, 1, 1, 5, 'smirnova_a', 'bcrypt_hash_level_10_5a6b7c8d9e0f', false),
(4, 3, 5, 6, 'volkova_e', 'bcrypt_hash_level_10_6a7b8c9d0e1f', false),
(3, 2, 2, 7, 'orlov_a', 'bcrypt_hash_level_10_7a8b9c0d1e2f', false),
(2, 2, 3, 8, 'kuznecova_y', 'bcrypt_hash_level_10_8a9b0c1d2e3f', false),
(5, 3, 3, 9, 'novikov_v', 'bcrypt_hash_level_10_9a0b1c2d3e4f', false),
(1, 1, 1, 10, 'sokolova_o', 'bcrypt_hash_level_10_0a1b2c3d4e5f', false),
(4, 3, 5, 11, 'lebedev_a', 'bcrypt_hash_level_level_10_1a2b3c4d5e6f', false),
(4, 3, 5, 12, 'pavlova_t', 'bcrypt_hash_level_10_2a3b4c5d6e7f', false);

-- Vulnerability Data (уязвимости)
INSERT INTO vulnerability (id_risk_assessment, id_vulnerability_details, name, hack_type, id_employee) VALUES
(1, 1, 'SQL Injection in Auth Module', 'Injection', 1),
(2, 2, 'Command Injection in Upload', 'Injection', NULL),
(3, 3, 'Path Traversal in File Access', 'Directory Traversal', 1),
(4, 1, 'Critical SQL Injection DB', 'Injection', 2),
(5, 2, 'Low Priority Command Inj', 'Injection', NULL),
(6, 4, 'XSS in User Profiles', 'Cross-Site Scripting', 5),
(7, 5, 'Buffer Overflow in Image Lib', 'Memory Corruption', 2),
(8, 6, 'Weak SSH Key Generation', 'Cryptography', NULL),
(9, 7, 'Unvalidated Redirects', 'Client-side', 1),
(10, 8, 'Missing API Authentication', 'Authentication', 5);

-- Incident Sources (источники инцидентов)
INSERT INTO incident_source (id_source_type, indentified_date) VALUES
(1, NOW() - INTERVAL '10 days'),
(2, NOW() - INTERVAL '20 days'),
(3, NOW() - INTERVAL '2 days'),
(4, NOW() - INTERVAL '15 days'),
(5, NOW() - INTERVAL '8 days'),
(6, NOW() - INTERVAL '12 days'),
(7, NOW() - INTERVAL '5 days'),
(2, NOW() - INTERVAL '3 days');

-- Incidents (инциденты)
INSERT INTO incident (id_sla, id_employee, id_incident_source, title, description, detective_time, fixed_time, status, processing_delay) VALUES
(1, 1, 1, 'SQL Injection Attempt', 'Попытка SQL injection в форме входа', NOW() - INTERVAL '10 days', NOW() - INTERVAL '5 days', 'resolved', false),
(1, 2, 2, 'Unauthorized Access', 'Несанкционированный доступ к базе данных', NOW() - INTERVAL '20 days', NULL, 'open', true),
(2, 3, 3, 'Data Exfiltration', 'Попытка утечки конфиденциальных данных', NOW() - INTERVAL '2 days', NOW(), 'resolved', false),
(1, 1, 4, 'DDoS Attack', 'DDoS атака на веб-сервер', NOW() - INTERVAL '15 days', NULL, 'open', false),
(2, 4, 5, 'Phishing Email', 'Фишинг письмо получено сотрудником', NOW() - INTERVAL '8 days', NOW() - INTERVAL '3 days', 'resolved', false),
(1, 5, 6, 'Malware Detection', 'Обнаружено вредоносное ПО на рабочей станции', NOW() - INTERVAL '12 days', NULL, 'in work', false),
(3, 1, 7, 'Privilege Escalation', 'Попытка повышения привилегий', NOW() - INTERVAL '5 days', NOW() - INTERVAL '4 days', 'resolved', false),
(2, 3, 8, 'Configuration Exposure', 'Утечка файлов конфигурации', NOW() - INTERVAL '3 days', NULL, 'open', true);

-- Remedial Measures (меры устранения)
INSERT INTO remedial_measure (id_incident, id_access_perm, title, description, average_actions, exec_date) VALUES
(1, 1, 'Patch SQL Vulnerability', 'Обновление базы данных и веб-приложения', 5, NOW() - INTERVAL '5 days'),
(2, 2, 'Access Rights Review', 'Проверка и пересмотр прав доступа', 3, NOW() - INTERVAL '10 days'),
(3, 1, 'Security Hardening', 'Усиление безопасности сетевых устройств', 8, NOW()),
(4, 1, 'Network Isolation DDoS', 'Изоляция пораженного сервера', 10, NOW() - INTERVAL '14 days'),
(5, 2, 'Email Filter Rules', 'Обновление фильтров электронной почты', 2, NOW() - INTERVAL '3 days'),
(6, 1, 'Full Antivirus Scan', 'Полное сканирование и очистка', 6, NULL),
(7, 1, 'SELinux Policy Update', 'Обновление политик SELinux', 4, NOW() - INTERVAL '4 days'),
(8, 2, 'Configuration Review', 'Аудит конфигурации и закрытие доступа', 7, NULL);

-- Playbooks (игровые книги по реагированию)
INSERT INTO playbook (id_remedial_measure, title, description) VALUES
(1, 'SQL Injection Response Playbook', 'Действия при обнаружении SQL injection'),
(2, 'Access Control Review Playbook', 'Процедура проверки управления доступом'),
(3, 'Security Hardening Playbook', 'Шаги усиления безопасности инфраструктуры'),
(4, 'DDoS Mitigation Playbook', 'Процедура митигации DDoS атак'),
(5, 'Phishing Response Playbook', 'Ответ на фишинг и удаление фишинг-писем'),
(6, 'Malware Removal Playbook', 'Процедура удаления вредоноса и восстановления'),
(7, 'Privilege Escalation Playbook', 'Блокировка и аудит попыток повышения привилегий'),
(8, 'Configuration Exposure Playbook', 'Ротация ключей и изоляция скомпрометированных сервисов');

-- Digital Artifacts (цифровые артефакты инцидентов)
INSERT INTO digital_artifacts (id_incident, artifact_type, hash_sum) VALUES
(1, 'malware_sample', 'a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6a1b2c3d4e5f6g7h8i9j0'),
(2, 'log_file', 'f1e2d3c4b5a6g7h8i9j0k1l2m3n4o5p6f1e2d3c4b5a6g7h8i9j0'),
(3, 'network_pcap', 'c1b2a3f4e5d6g7h8i9j0k1l2m3n4o5p6c1b2a3f4e5d6g7h8i9j0'),
(4, 'traffic_dump', 'd2e3f4a5b6c7g8h9i0j1k2l3m4n5o6p7d2e3f4a5b6c7g8h9i0j1'),
(5, 'email_message', 'e3f4a5b6c7d8g9h0i1j2k3l4m5n6o7p8e3f4a5b6c7d8g9h0i1j2'),
(6, 'infected_file', 'f4a5b6c7d8e9g0h1i2j3k4l5m6n7o8p9f4a5b6c7d8e9g0h1i2j3'),
(7, 'system_log', 'g5b6c7d8e9f0g1h2i3j4k5l6m7n8o9p0g5b6c7d8e9f0g1h2i3j4'),
(8, 'config_file', 'h6c7d8e9f0g1h2i3j4k5l6m7n8o9p0q1h6c7d8e9f0g1h2i3j4k5');

-- Log Files (журнал логов с деталями событий)
INSERT INTO log_files (id_incident, id_account, event_type, event_time, description) VALUES
(1, 1, 'SQL_INJECTION_ATTEMPT', NOW() - INTERVAL '10 days', 'Обнаружена попытка SQL injection с IP 192.168.1.100'),
(1, 1, 'PATTERN_MATCHED', NOW() - INTERVAL '10 days 2 hours', 'Сработал паттерн IDS для SQL injection'),
(2, 2, 'UNAUTHORIZED_ACCESS', NOW() - INTERVAL '20 days', 'Несанкционированная попытка доступа с аккаунта admin'),
(2, 2, 'FAILED_AUTH', NOW() - INTERVAL '20 days 30 minutes', 'Множественные неудачные попытки входа'),
(3, 3, 'DATA_EXFILTRATION', NOW() - INTERVAL '2 days', 'Обнаружена передача больших объемов данных'),
(3, 3, 'NETWORK_ALERT', NOW() - INTERVAL '2 days 1 hour', 'Необычная активность в сети обнаружена'),
(4, 1, 'DDOS_ATTACK', NOW() - INTERVAL '15 days', 'DDoS атака обнаружена на сервере 192.168.1.10'),
(4, 1, 'TRAFFIC_SPIKE', NOW() - INTERVAL '15 days 30 minutes', 'Резкий скачок трафика обнаружен'),
(5, 2, 'PHISHING_EMAIL', NOW() - INTERVAL '8 days', 'Фишинг письмо получено на почту'),
(5, 2, 'URL_CLICKED', NOW() - INTERVAL '8 days 4 hours', 'Пользователь нажал на фишинг ссылку'),
(6, 3, 'MALWARE_DETECTED', NOW() - INTERVAL '12 days', 'Вредоносное ПО обнаружено EDR агентом'),
(6, 3, 'FILE_QUARANTINED', NOW() - INTERVAL '12 days 30 minutes', 'Инфицированный файл помещен в карантин'),
(7, 4, 'PRIV_ESCALATION', NOW() - INTERVAL '5 days', 'Попытка повышения привилегий через sudo'),
(7, 4, 'AUDIT_ALERT', NOW() - INTERVAL '5 days 1 hour', 'Аудит записал несанкционированную операцию'),
(8, 5, 'CONFIG_EXPOSURE', NOW() - INTERVAL '3 days', 'Конфиденциальный файл конфигурации открыт'),
(8, 5, 'FILE_ACCESS_ALERT', NOW() - INTERVAL '3 days 2 hours', 'Непредвиденный доступ к файлу конфигурации');

-- Incident Severity Levels (уровни критичности инцидентов)
INSERT INTO severity_level (id_incident, id_damage, id_escalation_matrix, sev_level) VALUES
(1, 1, 1, 8),  -- High severity
(2, 2, 2, 9),  -- Critical
(3, 3, 1, 7),  -- High
(4, 1, 2, 10), -- Critical
(5, 2, 1, 6),  -- Medium-High
(6, 3, 2, 8),  -- High
(7, 1, 1, 7),  -- High
(8, 2, 2, 9);  -- Critical

-- MITRE Mapping (маппинг MITRE тактик и техник)
INSERT INTO mapping_mitre (id_tactic, id_technique) VALUES
(1, 1), -- Initial Access: Spearphishing Attachment
(1, 2), -- Initial Access: Spearphishing Link
(2, 3), -- Execution: Command Line Interface
(2, 4), -- Execution: PowerShell
(3, 5), -- Persistence: Registry Run Keys
(3, 6), -- Persistence: Scheduled Task
(4, 7), -- Privilege Escalation: Sudo
(4, 8), -- Privilege Escalation: SUID
(5, 10), -- Defense Evasion: Input Capture
(6, 9), -- Credential Access: OS Credential Dumping
(7, 11), -- Discovery: Network Service Scanning
(7, 12), -- Discovery: System Information Discovery
(8, 13), -- Lateral Movement: Lateral Tool Transfer
(9, 14), -- Collection: File Staging
(10, 15); -- Exfiltration: Data Transfer Size Limits

-- Techniques Used (используемые техники в уязвимостях)
INSERT INTO techniques_used (id_technique, id_vulnerability) VALUES
(1, 1),  -- Spearphishing to SQL Injection
(3, 2),  -- CLI to Command Injection
(5, 3),  -- Registry to Path Traversal
(2, 4),  -- Spearphishing to Critical SQL
(4, 5),  -- PowerShell to Low Priority
(2, 6),  -- Spearphishing to XSS
(6, 7),  -- Scheduled Task to Buffer Overflow
(9, 8),  -- OS Credential Dumping to SSH
(8, 9),  -- SUID to Unvalidated Redirects
(13, 10); -- Lateral Tool Transfer to API Auth

-- Fixed Vulnerabilities (исправленные уязвимости)
INSERT INTO fixed_vulnerabilities (id_vulnerability, id_patch) VALUES
(1, 1), -- SQL Injection patched with KB123456
(2, 2), -- Command Injection with MS2024-01
(3, 3), -- Path Traversal with CVE-2024-1234
(4, 2), -- Critical SQL with MS2024-01
(6, 5); -- XSS with Emergency Patch

-- Installed Software (установленное ПО на активах)
INSERT INTO installed_software (id_info_asset, id_software) VALUES
(1, 1),   -- WEB-Server-01: Windows Server
(1, 5),   -- WEB-Server-01: Nginx
(1, 10),  -- WEB-Server-01: OpenSSH
(2, 1),   -- WEB-Server-02: Windows Server
(2, 5),   -- WEB-Server-02: Nginx
(3, 2),   -- DB-Server-01: CentOS with PostgreSQL
(3, 7),   -- DB-Server-01: MySQL
(4, 2),   -- DB-Server-02: CentOS with PostgreSQL
(5, 3),   -- WorkStation-01: Windows 10
(6, 3),   -- WorkStation-02: Windows 10
(7, 3),   -- WorkStation-03: Windows 11
(8, 1),   -- Backup-Server: Windows Server
(8, 7),   -- Backup-Server: MySQL
(9, 2),   -- Mail-Server: Linux
(10, 2),  -- DNS-Server: Linux
(11, 3),  -- Laptop-Dev-01: Windows 11
(11, 8),  -- Laptop-Dev-01: Docker
(11, 9),  -- Laptop-Dev-01: Kubernetes
(12, 2),  -- Storage-System: Linux
(12, 7);  -- Storage-System: MySQL

-- Vulnerability to Asset Mapping (уязвимости активов)
INSERT INTO vulnerability_info_asset (id_vulnerability, id_info_asset) VALUES
(1, 1),   -- SQL Injection: WEB-Server-01
(1, 3),   -- SQL Injection: DB-Server-01
(2, 1),   -- Command Injection: WEB-Server-01
(2, 5),   -- Command Injection: WorkStation-01
(3, 3),   -- Path Traversal: DB-Server-01
(3, 2),   -- Path Traversal: WEB-Server-02
(4, 1),   -- Critical SQL: WEB-Server-01
(4, 3),   -- Critical SQL: DB-Server-01
(5, 5),   -- Low Priority: WorkStation-01
(5, 3),   -- Low Priority: DB-Server-01
(6, 5),   -- XSS: WorkStation-01
(6, 1),   -- XSS: WEB-Server-01
(7, 1),   -- Buffer Overflow: WEB-Server-01
(8, 10),  -- Weak SSH: DNS-Server
(9, 1),   -- Unvalidated Redirects: WEB-Server-01
(10, 3);  -- Missing API Auth: DB-Server-01

-- Compromised Info Assets (поврежденные активы)
INSERT INTO compromised_info_asset (id_incident, id_info_asset, downtime, damage_type) VALUES
(1, 1, 120, 'data_loss'),              -- 2 hours downtime, data loss
(2, 1, 240, 'data_exposure'),          -- 4 hours downtime, exposed data
(2, 3, 180, 'data_exposure'),          -- DB also affected
(3, 3, 60, 'downtime'),                -- 1 hour downtime
(4, 1, 480, 'performance_degradation'), -- 8 hours degraded service
(4, 2, 480, 'performance_degradation'), -- Both WEB servers affected
(5, 5, 30, 'infection'),               -- 30 min infection
(6, 5, 240, 'compromise'),             -- Workstation compromised
(6, 8, 120, 'data_exfiltration');      -- Backup server affected

-- Assessment Results (результаты оценки рисков)
INSERT INTO assessment_result (id_vulnerability, id_assessment) VALUES
(1, 1),  -- SQL Injection: Risk 70
(2, 2),  -- Command Injection: Risk 72
(3, 3),  -- Path Traversal: Risk 30
(4, 4),  -- Critical SQL: Risk 100
(5, 5),  -- Low Priority: Risk 12
(6, 6),  -- XSS: Risk 48
(7, 7),  -- Buffer Overflow: Risk 63
(8, 8),  -- Weak SSH: Risk 18
(9, 9),  -- Unvalidated Redirects: Risk 20
(10, 10); -- Missing API Auth: Risk 80

-- Exploited Vulnerabilities (эксплуатируемые уязвимости)
INSERT INTO exploited_vulnerability (id_vulnerability, id_incident, description) VALUES
(1, 1, 'Успешная эксплуатация SQL injection для доступа к таблице users'),
(2, 2, 'Использование команды для доступа к базе данных'),
(4, 4, 'Критическая уязвимость эксплуатирована в полной мере'),
(3, 5, 'Path traversal в системе для получения учетных данных'),
(6, 1, 'XSS использован для кража сессионного куки'),
(8, 7, 'Перебор слабых SSH ключей'),
(10, 2, 'API эндпоинт без проверки аутентификации');
