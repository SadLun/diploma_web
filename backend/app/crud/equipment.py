from sqlalchemy.orm import Session
from app.models.equipment import Equipment
from app.schemas.equipment import EquipmentCreate
from typing import Optional
from sqlalchemy import and_

def create_equipment(db: Session, equipment: EquipmentCreate):
    db_equipment = Equipment(
        name=equipment.name,
        warranty_years=equipment.warranty_years,
        min_temperature=equipment.min_temperature,
        max_temperature=equipment.max_temperature,
        link=equipment.link,
        category_id=equipment.category_id,
        mtbf_hours=equipment.mtbf_hours
    )
    db.add(db_equipment)
    db.commit()
    db.refresh(db_equipment)
    return db_equipment

def get_equipment(db: Session, equipment_id: int):
    return db.query(Equipment).filter(Equipment.id == equipment_id).first()

def get_equipments(db: Session, skip: int = 0, limit: int = 100):
    return db.query(Equipment).offset(skip).limit(limit).all()

def delete_equipment(db: Session, equipment_id: int):
    db_equipment = db.query(Equipment).filter(Equipment.id == equipment_id).first()
    if db_equipment:
        db.delete(db_equipment)
        db.commit()
    return db_equipment

def update_equipment(db: Session, equipment_id: int, equipment_update: EquipmentCreate):
    db_equipment = db.query(Equipment).filter(Equipment.id == equipment_id).first()
    if not db_equipment:
        return None
    db_equipment.name = equipment_update.name
    db_equipment.warranty_years = equipment_update.warranty_years
    db_equipment.min_temperature = equipment_update.min_temperature
    db_equipment.max_temperature = equipment_update.max_temperature
    db_equipment.link = equipment_update.link
    db_equipment.category_id = equipment_update.category_id
    db_equipment.mtbf_hours = equipment_update.mtbf_hours
    db.commit()
    db.refresh(db_equipment)
    return db_equipment


def search_equipments(
    db: Session,
    category_id: Optional[int] = None,
    min_temp: Optional[float] = None,
    max_temp: Optional[float] = None,
    min_mtbf: Optional[float] = None,
    name_contains: Optional[str] = None,
    skip: int = 0,
    limit: int = 100
):
    query = db.query(Equipment)

    if category_id is not None:
        query = query.filter(Equipment.category_id == category_id)
    
    if min_temp is not None:
        query = query.filter(Equipment.min_temperature >= min_temp)
    
    if max_temp is not None:
        query = query.filter(Equipment.max_temperature <= max_temp)
    
    if min_mtbf is not None:
        query = query.filter(Equipment.mtbf_hours >= min_mtbf)
    
    if name_contains is not None:
        query = query.filter(Equipment.name.ilike(f"%{name_contains}%"))
    
    return query.offset(skip).limit(limit).all()
