from fastapi import APIRouter

router = APIRouter(
    prefix="/health",
    tags=["Healthcheck"]
)

@router.get("/", tags=["Healthcheck"])
def healthcheck():
    return {"status": "OK"}
