from pydantic import BaseModel, Field
from typing import Optional
from math import log, exp

class EquipmentBase(BaseModel):
    name: str = Field(..., description="Наименование оборудования")
    warranty_years: Optional[int] = Field(None, description="Гарантия на оборудование в годах")
    min_temperature: Optional[float] = Field(None, description="Минимальная температура эксплуатации")
    max_temperature: Optional[float] = Field(None, description="Максимальная температура эксплуатации")
    link: Optional[str] = Field(None, description="Ссылка на страницу оборудования")
    category_id: int = Field(..., description="ID категории оборудования")
    mtbf_hours: Optional[float] = Field(None, description="MTBF (Среднее время безотказной работы) в часах")

    class Config:
        schema_extra = {
            "example": {
                "name": "Умный датчик температуры",
                "warranty_years": 2,
                "min_temperature": -20.5,
                "max_temperature": 70.0,
                "link": "http://example.com/device",
                "category_id": 5,
                "mtbf_hours": 50000
            }
        }

class EquipmentCreate(EquipmentBase):
    pass

class Equipment(EquipmentBase):
    id: int
    gamma_percent_resource: Optional[float] = None
    preservation_period: Optional[float] = None
    mode_coefficient_k: Optional[float] = None

    class Config:
        orm_mode = True

    @classmethod
    def from_orm_with_calculations(cls, obj):
        equipment = cls.from_orm(obj)
        if equipment.mtbf_hours and equipment.mtbf_hours > 0:
            equipment.gamma_percent_resource = equipment.mtbf_hours * log(0.975)
            equipment.preservation_period = (1 / (0.01 * (1 / equipment.mtbf_hours))) * log(0.99)

            # Расчет коэффициента K
            Ea = 0.28  # Энергия активации
            k_b = 8.617e-3  # Константа Больцмана
            T_actual = equipment.min_temperature if equipment.min_temperature is not None else 25  # Температура в °C
            term = (1 / (T_actual + 273)) - (1 / 298)
            exponent = (-Ea / k_b) * term
            equipment.mode_coefficient_k = exp(exponent)
        return equipment
