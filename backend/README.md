# Equipment Management API

Проект представляет собой серверную часть для управления оборудованием.

**Цель:**  
Создание API для работы с оборудованием и категориями, с автоматическим расчётом показателей надёжности.

---

## ⚙️ Используемые технологии

- Python 3.11+
- FastAPI
- PostgreSQL
- SQLAlchemy
- Pydantic
- Docker + Docker Compose (опционально)
- dotenv (python-dotenv)

---

## 📦 Установка и запуск проекта

1. Клонируйте репозиторий:

```bash
git clone https://github.com/yourfriend/projectname.git
cd projectname/backend
```

2. Создайте виртуальное окружение и активируйте его:

```bash
python -m venv venv
venv\Scripts\activate  # Windows
# или
source venv/bin/activate  # Linux/Mac
```

3. Установите зависимости:

```bash
pip install -r requirements.txt
```

4. Настройте файл `.env`:

```ini
DB_HOST=localhost
DB_PORT=5432
DB_NAME=equipment_db
DB_USER=your_db_user
DB_PASSWORD=your_db_password
```

5. Запустите сервер:

```bash
uvicorn app.main:app --reload
```

---

## 🛠️ Структура проекта

```
backend/
├── app/
│   ├── crud/          # Бизнес-логика для работы с базой
│   ├── models/        # SQLAlchemy модели
│   ├── routers/       # Маршруты FastAPI
│   ├── schemas/       # Pydantic-схемы для валидации
│   ├── core/          # Логирование и обработка ошибок
│   ├── database.py    # Подключение к базе данных
│   └── main.py        # Точка входа в приложение
├── .env               # Настройки подключения к БД
├── requirements.txt   # Список зависимостей
├── README.md          # Документация проекта
└── logs/              # Папка для логов
```

---

## 🌐 API Документация

Swagger UI доступен по адресу:  
[http://localhost:8000/docs](http://localhost:8000/docs)

Redoc доступен по адресу:  
[http://localhost:8000/redoc](http://localhost:8000/redoc)

---

## 🧪 Основные эндпоинты

- `/categories/` — CRUD для категорий
- `/equipments/` — CRUD и поиск для оборудования
- `/health/` — Проверка состояния сервера

---

## 🚀 Планы на будущее

- Добавить авторизацию и права доступа
- Миграции базы через Alembic
- CI/CD пайплайн
- Деплой через Docker + VPS

---