import pandas as pd
from sqlalchemy.orm import Session
from app.database import SessionLocal
from app.models.equipment import Equipment
from app.models.category import Category
import os

# Путь до CSV файла
csv_file_path = "C:/Users/Yasch/Downloads/equipment_import_ready.csv"
error_log_path = "import_errors.log"

def import_from_csv():
    db: Session = SessionLocal()

    if not os.path.exists(csv_file_path):
        print(f"Файл не найден: {csv_file_path}")
        return

    df = pd.read_csv(csv_file_path)

    categories_cache = {}
    imported_count = 0
    error_count = 0

    # Очищаем старый лог ошибок
    open(error_log_path, 'w').close()

    for idx, row in df.iterrows():
        try:
            name = row['Наименование оборудования']
            warranty_years = row['Гарантия']
            min_temp = row['Минимальная температура']
            max_temp = row['Максимальная температура']
            link = row['Ссылка']
            category_name = row['Категория оборудования']
            mtbf_hours = row['MTBF']

            if pd.isna(name) or pd.isna(category_name):
                continue  # Без имени или категории пропускаем

            # Ищем или создаем категорию
            category = categories_cache.get(category_name)
            if not category:
                category = db.query(Category).filter(Category.name == category_name).first()
                if not category:
                    category = Category(name=category_name)
                    db.add(category)
                    db.commit()
                    db.refresh(category)
                categories_cache[category_name] = category

            # Создаём оборудование
            equipment = Equipment(
                name=name,
                warranty_years=int(warranty_years) if not pd.isna(warranty_years) and warranty_years != '' else None,
                min_temperature=float(min_temp) if not pd.isna(min_temp) and min_temp != '' else None,
                max_temperature=float(max_temp) if not pd.isna(max_temp) and max_temp != '' else None,
                link=link if not pd.isna(link) and link != '' else None,
                category_id=category.id,
                mtbf_hours=float(mtbf_hours) if not pd.isna(mtbf_hours) and mtbf_hours != '' else None
            )

            db.add(equipment)
            imported_count += 1

        except Exception as e:
            error_count += 1
            with open(error_log_path, 'a', encoding='utf-8') as f:
                f.write(f"Ошибка в строке {idx+2}: {str(e)}\n")
            continue

    db.commit()
    db.close()

    print(f"Импорт завершён: добавлено {imported_count} записей оборудования.")
    print(f"Ошибок при импорте: {error_count}. Подробности смотри в файле {error_log_path}")

if __name__ == "__main__":
    import_from_csv()