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
        from_attributes = True

class EquipmentCreate(EquipmentBase):
    pass

class Equipment(EquipmentBase):
    id: int
    gamma_percent_resource: Optional[float] = None
    preservation_period: Optional[float] = None
    mode_coefficient_k: Optional[float] = None
    mode_coefficient_k_min_temp: Optional[float] = None
    mode_coefficient_k_max_temp: Optional[float] = None
    mtbf_exploitation_min_temp: Optional[float] = Field(None, description="MTBF при эксплуатации (по мин. температуре)")
    mtbf_exploitation_max_temp: Optional[float] = Field(None, description="MTBF при эксплуатации (по макс. температуре)")
    lbd_e:  Optional[float] = None
    lbd_ex_min:  Optional[float] = None
    lbd_ex_max:  Optional[float] = None


    class Config:
        orm_mode = True

    @classmethod
    def from_orm_with_calculations(cls, obj):
        equipment = cls.from_orm(obj)
        if equipment.mtbf_hours and equipment.mtbf_hours > 0:
            equipment.gamma_percent_resource = -equipment.mtbf_hours * log(0.975)
            equipment.preservation_period = -(1 / (0.01 * (1 / equipment.mtbf_hours))) * log(0.99)

            Ea = 0.28
            k_b = 8.617e-3

            def calc_k(temp):
                try:
                    T = temp + 273
                    term = (1 / T) - (1 / 298)
                    exponent = (-Ea / k_b) * term
                    return round(exp(exponent), 5)
                except:
                    return None

            T_actual = equipment.min_temperature if equipment.min_temperature is not None else 25
            equipment.mode_coefficient_k = calc_k(T_actual)

            if equipment.min_temperature is not None:
                equipment.mode_coefficient_k_min_temp = calc_k(equipment.min_temperature)

            if equipment.max_temperature is not None:
                equipment.mode_coefficient_k_max_temp = calc_k(equipment.max_temperature)

            # Базовая интенсивность отказов
            lambda_e = 1 / equipment.mtbf_hours if equipment.mtbf_hours else None
            equipment.lbd_e = lambda_e

            # по min temp
            if lambda_e and equipment.mode_coefficient_k_min_temp:
                lambda_ex_min = lambda_e * equipment.mode_coefficient_k_min_temp
                equipment.mtbf_exploitation_min_temp = round(1 / lambda_ex_min, 3)
                equipment.lbd_ex_min = lambda_ex_min

            # по max temp
            if lambda_e and equipment.mode_coefficient_k_max_temp:
                lambda_ex_max = lambda_e * equipment.mode_coefficient_k_max_temp
                equipment.mtbf_exploitation_max_temp = round(1 / lambda_ex_max, 3)
                equipment.lbd_ex_max = lambda_ex_max


        return equipment

