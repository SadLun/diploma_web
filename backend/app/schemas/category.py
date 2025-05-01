from pydantic import BaseModel
from typing import Optional

class CategoryBase(BaseModel):
    name: str

    class Config:
        from_attributes = True

class CategoryWithStats(BaseModel):
    id: int
    name: str
    avg_mtbf_hours: Optional[float] = None
    avg_gamma_percent_resource: Optional[float] = None
    avg_preservation_period: Optional[float] = None
    avg_mode_coefficient_k: Optional[float] = None
    avg_mode_coefficient_k_min_temp: Optional[float] = None
    avg_mode_coefficient_k_max_temp: Optional[float] = None
    avg_mtbf_exploitation_min_temp: Optional[float] = None
    avg_mtbf_exploitation_max_temp: Optional[float] = None



class CategoryCreate(CategoryBase):
    pass

class Category(CategoryBase):
    id: int

    class Config:
        orm_mode = True
