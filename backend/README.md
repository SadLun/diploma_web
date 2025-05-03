# 🧠 Diploma Web Server Backend

Серверная часть проекта для обработки оборудования, расчётов ресурса, импорта данных и взаимодействия через REST API.

---

## 🚀 Быстрый старт с Docker

Ты можешь запустить весь проект (сервер + БД) одной командой — нужен только установленный Docker

---

### 🧰 Установка Docker

1. Скачай и установи Docker Desktop:  

2. Проверь, что работает:

```bash
docker --version
```

---

### 🧾 Клонирование репозитория

### 🛠️ Запуск проекта

```bash
docker compose up --build
```

📦 Это поднимет:
- PostgreSQL 15
- FastAPI сервер
- Автоматическую загрузку дампа базы (`equipment_backup.sql`)

---

### 🐘 Дамп базы данных

База данных автоматически загружается из `init_db/equipment_backup.sql` при первом запуске.  

📁 Структура папки:

```
backend/
├── init_db/
│   └── equipment_backup.sql
│
├── docker-compose.yml
├── Dockerfile
└── .env
```

---

### 🧠 Документация API

- Swagger: [http://localhost:8000/docs](http://localhost:8000/docs)
- ReDoc: [http://localhost:8000/redoc](http://localhost:8000/redoc)

---

## ⚙️ Переменные окружения (`.env`)

Создай файл `.env` (или используй `.env.example`):

```env
DB_HOST=db
DB_PORT=5432
DB_NAME=postgres
DB_USER=postgres
DB_PASSWORD=postgres
```

📌 Эти переменные используются и FastAPI, и в Docker PostgreSQL.

---

## 📦 Команды управления

| Действие                         | Команда                                |
|----------------------------------|-----------------------------------------|
| Запуск сервиса                   | `docker compose up --build`             |
| Остановка                        | `docker compose down`                   |
| Очистка БД (удаление volume)     | `docker compose down -v`                |
| Пересоздание без кэша            | `docker compose up --build --no-cache` |

---

## 🧪 Тестирование

Проверь работу API через:

- `/health` — Healthcheck
- `/equipments` — CRUD оборудование
- `/categories` — CRUD категории
- `/equipments/search` — фильтрация и расчётные поля

---

## 🔐 Авторизация (опционально)

Если будет внедряться — добавится JWT. Пока доступ открыт.

---

## 📂 Структура проекта

```
app/
├── crud/
├── models/
├── routers/
├── schemas/
├── database.py
├── main.py
└── utils.py (расчётные поля, логирование и т.д.)

init_db/
├── equipment_backup.sql

Dockerfile
docker-compose.yml
.env
requirements.txt
```

---


## 📁 Импорт и экспорт оборудования (Excel)

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

## 📄 Лицензия

MIT, но если найдёшь баг — **почини и пришли PR, не молчи как broken стояк.**

---