from sqlalchemy import Column, Integer, Float, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship
from datetime import datetime
from app.database import Base

class CalculationRecord(Base):
    __tablename__ = "calculation_records"

    id                = Column(Integer, primary_key=True, index=True)
    equipment_id      = Column(Integer, ForeignKey("equipment.id"), nullable=False)
    temperature       = Column(Float, nullable=False)
    calculated_mtbf   = Column(Float, nullable=False)
    calculated_lambda = Column(Float, nullable=False)
    timestamp         = Column(DateTime, server_default=func.now())

    equipment = relationship("Equipment", back_populates="calculations")