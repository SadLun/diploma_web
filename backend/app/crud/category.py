from sqlalchemy.orm import Session
from app.models.category import Category
from app.schemas.category import CategoryCreate
from sqlalchemy import func
from app.models import Category, Equipment
from app.schemas.category import CategoryWithStats
from typing import List, Optional
from app.schemas.equipment import Equipment as EquipmentSchema

def get_categories_with_averages(db: Session) -> List[CategoryWithStats]:
    categories = db.query(Category).all()
    result = []

    for category in categories:
        equipments = db.query(Equipment).filter(Equipment.category_id == category.id).all()
        if not equipments:
            continue

        # расчётные поля
        calculated = [EquipmentSchema.from_orm_with_calculations(e) for e in equipments]

        def avg(field: str) -> Optional[float]:
            values = [getattr(e, field) for e in calculated if getattr(e, field) is not None]
            return round(sum(values) / len(values), 3) if values else None

        result.append(CategoryWithStats(
            id=category.id,
            name=category.name,
            avg_mtbf_hours=avg("mtbf_hours"),
            avg_gamma_percent_resource=avg("gamma_percent_resource"),
            avg_preservation_period=avg("preservation_period"),
            avg_mode_coefficient_k=avg("mode_coefficient_k"),
            avg_mode_coefficient_k_min_temp=avg("mode_coefficient_k_min_temp"),
            avg_mode_coefficient_k_max_temp=avg("mode_coefficient_k_max_temp"),
            avg_mtbf_exploitation_min_temp=avg("mtbf_exploitation_min_temp"),
            avg_mtbf_exploitation_max_temp=avg("mtbf_exploitation_max_temp"),
        ))

    return result

def create_category(db: Session, category: CategoryCreate):
    db_category = Category(name=category.name)
    db.add(db_category)
    db.commit()
    db.refresh(db_category)
    return db_category

def get_category(db: Session, category_id: int):
    return db.query(Category).filter(Category.id == category_id).first()

def get_categories(db: Session, skip: int = 0, limit: int = 100):
    return db.query(Category).offset(skip).limit(limit).all()

def delete_category(db: Session, category_id: int):
    db_category = db.query(Category).filter(Category.id == category_id).first()
    if db_category:
        db.delete(db_category)
        db.commit()
    return db_category

def update_category(db: Session, category_id: int, category_update: CategoryCreate):
    db_category = db.query(Category).filter(Category.id == category_id).first()
    if not db_category:
        return None
    db_category.name = category_update.name
    db.commit()
    db.refresh(db_category)
    return db_category
