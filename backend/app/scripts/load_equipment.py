import openpyxl
from sqlalchemy.orm import Session
from app.database import SessionLocal
from app.models.equipment import Equipment
from app.models.category import Category
import math

# Путь к файлу
file_path = "C:/Users/Yasch/Downloads/sorted_equipment_cleaned.xlsx"

def load_equipment():
    db: Session = SessionLocal()

    wb = openpyxl.load_workbook(file_path)
    sheet = wb.active

    categories_cache = {}

    # Пропустим заголовки
    for row in sheet.iter_rows(min_row=2, values_only=True):
        data = row[:7]  # Берем только первые 7 ячеек
        name, warranty_years, min_temp, max_temp, link, category_name, mtbf_value = data

        # Обработка пустых полей
        if not name or not category_name:
            continue

        # Обрабатываем MTBF
        if isinstance(mtbf_value, str) and "–" in mtbf_value:
            mtbf_value = mtbf_value.split("–")[0]  # Берём минимальное значение диапазона
        try:
            mtbf_value = float(mtbf_value)
        except (ValueError, TypeError):
            mtbf_value = None

        # Ищем или создаём категорию
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
            warranty_years=warranty_years if warranty_years is not None else None,
            min_temperature=min_temp if min_temp is not None else None,
            max_temperature=max_temp if max_temp is not None else None,
            link=link if link else None,
            category_id=category.id,
            mtbf_hours=mtbf_value
        )

        db.add(equipment)

    db.commit()
    db.close()

if __name__ == "__main__":
    load_equipment()
