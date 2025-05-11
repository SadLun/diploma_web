from pydantic import BaseModel, ConfigDict
from datetime import datetime
from typing import Optional

class CalculationBase(BaseModel):
    equipment_id: int
    temperature:  float
    calculated_mtbf: float
    calculated_lambda: float

class CalculationCreate(CalculationBase):
    pass

class Calculation(CalculationBase):
    id:                 int
    timestamp:          datetime
    
    model_config = {"from_attributes": True}
