from sqlalchemy import Column, Integer, String, Float, ForeignKey, Text
from sqlalchemy.orm import relationship
from app.database import Base

class Equipment(Base):
    __tablename__ = "equipment"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(Text, nullable=False)
    warranty_years = Column(Integer)
    min_temperature = Column(Float)
    max_temperature = Column(Float)
    link = Column(Text)
    category_id = Column(Integer, ForeignKey("categories.id"), nullable=False)
    mtbf_hours = Column(Float)

    category = relationship("Category", backref="equipments")
    calculations = relationship("CalculationRecord",back_populates="equipment",cascade="all, delete-orphan")