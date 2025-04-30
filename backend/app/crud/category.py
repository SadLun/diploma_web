from sqlalchemy.orm import Session
from app.models.category import Category
from app.schemas.category import CategoryCreate

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
