from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import get_db
from app import crud, schemas
from typing import Optional

router = APIRouter(
    prefix="/equipments",
    tags=["Equipments"]
)

@router.post("/", response_model=schemas.Equipment)
def create_equipment(equipment: schemas.EquipmentCreate, db: Session = Depends(get_db)):
    return crud.equipment.create_equipment(db, equipment)

@router.get("/{equipment_id}", response_model=schemas.Equipment)
def read_equipment(equipment_id: int, db: Session = Depends(get_db)):
    db_equipment = crud.equipment.get_equipment(db, equipment_id)
    if db_equipment is None:
        raise HTTPException(status_code=404, detail="Equipment not found")
    return db_equipment

@router.get("/", response_model=list[schemas.Equipment])
def read_equipments(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return crud.equipment.get_equipments(db, skip=skip, limit=limit)

@router.delete("/{equipment_id}", response_model=schemas.Equipment)
def delete_equipment(equipment_id: int, db: Session = Depends(get_db)):
    db_equipment = crud.equipment.delete_equipment(db, equipment_id)
    if db_equipment is None:
        raise HTTPException(status_code=404, detail="Equipment not found")
    return db_equipment

@router.get("/{equipment_id}", response_model=schemas.Equipment)
def read_equipment(equipment_id: int, db: Session = Depends(get_db)):
    db_equipment = crud.equipment.get_equipment(db, equipment_id)
    if db_equipment is None:
        raise HTTPException(status_code=404, detail="Equipment not found")
    return schemas.Equipment.from_orm_with_calculations(db_equipment)

@router.get("/", response_model=list[schemas.Equipment])
def read_equipments(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    db_equipments = crud.equipment.get_equipments(db, skip=skip, limit=limit)
    return [schemas.Equipment.from_orm_with_calculations(eq) for eq in db_equipments]

@router.put("/{equipment_id}", response_model=schemas.Equipment)
def update_equipment(equipment_id: int, equipment: schemas.EquipmentCreate, db: Session = Depends(get_db)):
    db_equipment = crud.equipment.update_equipment(db, equipment_id, equipment)
    if db_equipment is None:
        raise HTTPException(status_code=404, detail="Equipment not found")
    return schemas.Equipment.from_orm_with_calculations(db_equipment)

@router.get("/search/", response_model=list[schemas.Equipment])
def search_equipments(
    category_id: Optional[int] = None,
    min_temp: Optional[float] = None,
    max_temp: Optional[float] = None,
    min_mtbf: Optional[float] = None,
    name_contains: Optional[str] = None,
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db)
):
    db_equipments = crud.equipment.search_equipments(
        db,
        category_id=category_id,
        min_temp=min_temp,
        max_temp=max_temp,
        min_mtbf=min_mtbf,
        name_contains=name_contains,
        skip=skip,
        limit=limit
    )
    return [schemas.Equipment.from_orm_with_calculations(eq) for eq in db_equipments]
