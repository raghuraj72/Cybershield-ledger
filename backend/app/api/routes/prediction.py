from fastapi import APIRouter
from app.services.ai.transition_dag import KillChainPredictor

router = APIRouter(prefix="/prediction", tags=["Attack Prediction"])

@router.get("/next-stage/{current_stage}")
async def predict_stage(current_stage: str):
    result = KillChainPredictor.predict_next_stage(current_stage)
    return {"status": "success", "data": result}
