# Equipment Management API

Серверная часть проекта для управления оборудованием с автоматическим расчётом характеристик надёжности.

---

## ⚙️ Используемые технологии

- Python 3.11+
- FastAPI
- PostgreSQL
- SQLAlchemy
- Pydantic
- Docker + Docker Compose (опционально)
- dotenv (`python-dotenv`)

---


### 🗄️ Развёртывание базы данных на сервере

Для переноса базы данных на сервер можно использовать предварительно созданный дамп PostgreSQL, который хранится в репозитории: equipment_db_backup.dumpp.dump

---


### 📥 Перенос файла на сервер

Перенесите файл на сервер, например через `scp`:

```bash
scp equipment_db_backup.dump user@your.server.ip:/home/user/
```

---

### 🏗️ Восстановление базы на сервере

1. Подключитесь к серверу.
2. Создайте пустую базу данных:

```bash
createdb -U your_db_user -h localhost -p 5432 new_equipment_db
```

3. Восстановите данные из дампа:

```bash
pg_restore -U your_db_user -h localhost -p 5432 -d new_equipment_db -v equipment_db_backup.dump
```

---

📌 **Важно:**
- Перед восстановлением убедитесь, что база уже создана.
- Пользователь PostgreSQL должен иметь права на создание объектов.
- Восстановление возможно только в совместимых версиях PostgreSQL.

## 📦 Установка и запуск проекта

1. Установите зависимости:

```bash
pip install -r requirements.txt
```

2. Настройте файл `.env`:

```ini
DB_HOST=localhost
DB_PORT=5432
DB_NAME=equipment_db
DB_USER=your_db_user
DB_PASSWORD=your_db_password
```

3. Запустите сервер:

```bash
uvicorn app.main:app --reload
```

---

## 🛠️ Структура проекта

```
backend/
├── app/
│   ├── crud/          # Бизнес-логика для работы с БД
│   ├── models/        # SQLAlchemy модели
│   ├── routers/       # Маршруты FastAPI
│   ├── schemas/       # Pydantic-схемы для валидации
│   ├── core/          # Логирование и обработка ошибок
│   ├── database.py    # Подключение к БД
│   ├── main.py        # Точка входа в приложение
│   └── scripts/       # Скрипты импорта данных
├── .env               # Настройки подключения
├── requirements.txt   # Зависимости
├── README.md          # Документация проекта
└── logs/              # Логи
```

---

## 🌐 Документация API

Swagger UI доступен по адресу:  
[http://localhost:8000/docs](http://localhost:8000/docs)

Redoc доступен по адресу:  
[http://localhost:8000/redoc](http://localhost:8000/redoc)

---

## 🧪 Основные возможности API

### Категории (`/categories/`)
- `POST /categories/` — Создать категорию
- `GET /categories/` — Получить все категории
- `GET /categories/{id}` — Получить категорию по ID
- `PUT /categories/{id}` — Обновить категорию
- `DELETE /categories/{id}` — Удалить категорию

**Валидация:**
- При обновлении и удалении проверяется существование категории.

---

### Оборудование (`/equipments/`)
- `POST /equipments/` — Создать оборудование
- `GET /equipments/` — Получить всё оборудование
- `GET /equipments/{id}` — Получить оборудование по ID
- `PUT /equipments/{id}` — Обновить оборудование
- `DELETE /equipments/{id}` — Удалить оборудование
- `GET /equipments/search/` — Поиск оборудования с фильтрами

**Особенности:**
- При создании и обновлении оборудования проверяется существование `category_id`.
- При получении оборудования автоматически рассчитываются:
  - `gamma_percent_resource`
  - `preservation_period`
  - `mode_coefficient_k`

---

### Health Check (`/health/`)
- `GET /health/` — Проверка состояния сервера.

---

## 📈 Автоматический расчёт полей

При любом чтении данных об оборудовании (`GET` запросах) система автоматически рассчитывает:
- Гамма-процентный ресурс (`gamma_percent_resource`)
- Срок сохранности оборудования (`preservation_period`)
- Коэффициент режима (`mode_coefficient_k`)

Расчётные поля в базе **не хранятся** — считаются динамически!

---

## 🧩 Импорт данных

Импорт из CSV через скрипт:

```bash
python -m app.scripts.import_from_csv
```

Ошибки импорта записываются в файл `import_errors.log`.

---

## 🛠️ Логирование

Все события сервера записываются в:

- Консоль
- Файл `logs/app.log`

---

