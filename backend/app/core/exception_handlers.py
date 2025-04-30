from fastapi import Request
from fastapi.responses import JSONResponse
from app.core.logger import logger

async def validation_exception_handler(request: Request, exc):
    logger.error(f"Validation error: {exc}")
    return JSONResponse(
        status_code=422,
        content={"detail": "Invalid data", "errors": str(exc)}
    )

async def general_exception_handler(request: Request, exc):
    logger.error(f"Unexpected error: {exc}")
    return JSONResponse(
        status_code=500,
        content={"detail": "Internal Server Error", "errors": str(exc)}
    )
