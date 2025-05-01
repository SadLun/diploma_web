from fastapi import FastAPI
from fastapi.exceptions import RequestValidationError
from app.database import Base, engine
from app.models import category, equipment
from app.routers import category as category_router
from app.routers import equipment as equipment_router
from app.core.exception_handlers import validation_exception_handler, general_exception_handler
from app.core.logger import logger
from app.routers import health as health_router
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

origins = [
    "http://localhost:3000",  # адрес фронта в браузере
    "http://frontend:80",     # адрес фронта внутри Docker-сети
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

Base.metadata.create_all(bind=engine)

app.include_router(category_router.router)
app.include_router(equipment_router.router)

#Живой?
app.include_router(health_router.router)

# Обработчики ошибок
app.add_exception_handler(RequestValidationError, validation_exception_handler)
app.add_exception_handler(Exception, general_exception_handler)

@app.get("/")
def read_root():
    logger.info("Root endpoint called")
    return {"Hello": "World"}
