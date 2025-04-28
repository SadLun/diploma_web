import logging
from logging.handlers import RotatingFileHandler
import os

# Создаём директорию для логов, если нет
os.makedirs("logs", exist_ok=True)

# Настройка ротации файлов (каждый файл до 5 МБ, храним до 5 файлов)
file_handler = RotatingFileHandler(
    "logs/app.log", maxBytes=5*1024*1024, backupCount=5, encoding="utf-8"
)

file_formatter = logging.Formatter(
    "%(asctime)s - %(levelname)s - %(message)s"
)
file_handler.setFormatter(file_formatter)

# Настройка вывода в консоль
console_handler = logging.StreamHandler()
console_handler.setFormatter(file_formatter)

# Общий логгер
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
logger.addHandler(file_handler)
logger.addHandler(console_handler)
