# 🛠️ Запуск проекта

```bash
docker compose up --build
```

📦 Это поднимет:
- PostgreSQL 15
- FastAPI сервер
- Автоматическую загрузку дампа базы (`equipment_backup.sql`)
- Клиентскую часть приложения

---

# 🐘 Дамп базы данных

База данных автоматически загружается из `init_db/equipment_backup.sql` при первом запуске.

---

# 🧠 Документация API

- Swagger: [http://localhost:8000/docs](http://localhost:8000/docs)
- ReDoc: [http://localhost:8000/redoc](http://localhost:8000/redoc)

---

# 📦 Команды управления

| Действие                         | Команда                                |
|----------------------------------|-----------------------------------------|
| Запуск сервиса                   | `docker compose up --build`             |
| Остановка                        | `docker compose down`                   |
| Очистка БД (удаление volume)     | `docker compose down -v`                |
| Пересоздание без кэша            | `docker compose up --build --no-cache` |

---

# 📁 Импорт и экспорт оборудования (Excel)

Система поддерживает загрузку и выгрузку данных об оборудовании в формате `.xlsx` с помощью HTTP-эндпоинтов.

### 🔼 Импорт оборудования

**URL:** `POST /equipments/import`
**Описание:** загружает файл Excel с записями оборудования и добавляет их в базу данных.
**Тип запроса:** `multipart/form-data`

#### 📄 Ожидаемый формат файла `.xlsx`:

| name           | warranty\_years | min\_temperature | max\_temperature | link        | category\_id | mtbf\_hours |
| -------------- | --------------- | ---------------- | ---------------- | ----------- | ------------ | ----------- |
| Example Device | 3               | -10              | 55               | http\://... | 1            | 2000        |

* **`category_id`** должен быть валидным `id` существующей категории.
* Пустые значения обрабатываются как `null`.

#### 🧪 Пример запроса (cURL):

```bash
curl -X POST "http://localhost:8000/equipments/import" \
  -F "file=@./equipment_import.xlsx"
```

---

### 🔽 Экспорт оборудования

**URL:** `GET /equipments/export`
**Описание:** возвращает `.xlsx` файл со всеми записями оборудования.
**Тип ответа:** `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`

#### 🧪 Пример запроса (cURL):

```bash
curl -X GET "http://localhost:8000/equipments/export" -o equipment_export.xlsx
```
---
