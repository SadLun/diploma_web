from pydantic import BaseModel

class CategoryBase(BaseModel):
    name: str

    class Config:
        from_attributes = True

class CategoryCreate(CategoryBase):
    pass

class Category(CategoryBase):
    id: int

    class Config:
        orm_mode = True
