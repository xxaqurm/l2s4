
-- ТЕСТ 4. Автоматическое изменение статуса

UPDATE mitigation_action
SET status = 'выполнено'
WHERE incident_id = 1;

SELECT id, status
FROM incident
WHERE id = 1;



-- ТЕСТ 5. Контроль срока устранения

UPDATE incident
SET fixed_time = reg_date + INTERVAL '100 hours'
WHERE id = 1;

SELECT id, processing_delay
FROM incident
WHERE id = 1;



-- ТЕСТ 6. Статус «новый» по умолчанию

INSERT INTO incident (source)
VALUES ('Firewall');

SELECT id, status
FROM incident
ORDER BY id DESC
LIMIT 1;



-- ТЕСТ 7. Запрет удаления уязвимости

-- Должна возникнуть ошибка,
-- если vulnerability.id = 1 используется в incident
DELETE FROM vulnerability
WHERE id = 1;



-- ТЕСТ 8. Обновление количества инцидентов

INSERT INTO incident (source, asset_id)
VALUES ('SIEM', 1);

SELECT id, incident_count
FROM information_asset
WHERE id = 1;



-- ТЕСТ 9. Проверка ответственного сотрудника

-- Должна возникнуть ошибка
UPDATE incident
SET status = 'в работе'
WHERE id = 1;



-- ТЕСТ 10. Автоматическая дата закрытия

UPDATE incident
SET status = 'закрыт'
WHERE id = 1;

SELECT id, fixed_time
FROM incident
WHERE id = 1;