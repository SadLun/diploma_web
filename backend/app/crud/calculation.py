from sqlalchemy.orm import Session
from app.models.calculation import CalculationRecord
from app.schemas.calculation import CalculationCreate
from app.schemas.equipment import Equipment  # уже есть

def create_record(db: Session, data: CalculationCreate) -> CalculationRecord:
    """
    Высчитываем показатели и сохраняем запись.
    """
    # 1) берём оборудование + его расчётные коэффициенты
    equip = db.get(Equipment, data.equipment_id)
    if equip is None:
        raise ValueError("Equipment not found")

    tmp_equipment = Equipment.from_orm_with_calculations(equip)

    # 2) применяем формулы из изображения
    #    MTBFэх  = MTBFe * k(температура)
    #    λэх     = 1 / MTBFэх
    k = tmp_equipment.mode_coefficient_k  # уже считается внутри schema
    T = data.temperature
    if T is not None:
        # пересчитать k под T
        k = tmp_equipment._calc_k(T)   # либо вынесите calc_k в utils

    mtbf_ex = tmp_equipment.mtbf_hours * k if k and tmp_equipment.mtbf_hours else None
    lbd_ex  = 1 / mtbf_ex if mtbf_ex else None

    record = CalculationRecord(
        equipment_id      = data.equipment_id,
        temperature       = data.temperature,
        calculated_mtbf   = mtbf_ex,
        calculated_lambda = lbd_ex,
    )
    db.add(record)
    db.commit()
    db.refresh(record)
    return record

def get_records_by_equipment(db: Session, equipment_id: int):
    return db.query(CalculationRecord)\
             .filter(CalculationRecord.equipment_id == equipment_id)\
             .order_by(CalculationRecord.timestamp.desc())\
             .all()


def create(db: Session, rec_in: CalculationCreate) -> CalculationRecord:
    db_rec = CalculationRecord(**rec_in.model_dump())
    db.add(db_rec)
    db.commit()
    db.refresh(db_rec)
    return db_rec