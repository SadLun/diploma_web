from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import get_db
from app.schemas.calculation import CalculationCreate, Calculation
from app.crud.calculation import create_record, get_records_by_equipment

router = APIRouter(prefix="/calculations", tags=["Calculations"])

@router.post("/", response_model=Calculation)
def add_calculation(data: CalculationCreate, db: Session = Depends(get_db)):
    try:
        return create_record(db, data)
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))

@router.get("/{equipment_id}", response_model=list[Calculation])
def list_calculations(equipment_id: int, db: Session = Depends(get_db)):
    return get_records_by_equipment(db, equipment_id)
