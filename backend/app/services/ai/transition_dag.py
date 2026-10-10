from typing import Dict, List, Any

class KillChainPredictor:
    STAGES = [
        "Initial Access", "Execution", "Persistence", 
        "Privilege Escalation", "Lateral Movement", 
        "Collection", "Exfiltration"
    ]

    TRANSITIONS = {
        "Initial Access": {"Execution": 0.75, "Persistence": 0.20, "Discovery": 0.05},
        "Execution": {"Privilege Escalation": 0.60, "Persistence": 0.30, "Lateral Movement": 0.10},
        "Privilege Escalation": {"Lateral Movement": 0.70, "Collection": 0.20, "Exfiltration": 0.10},
        "Lateral Movement": {"Collection": 0.65, "Exfiltration": 0.25, "Execution": 0.10},
        "Collection": {"Exfiltration": 0.85, "Persistence": 0.15}
    }

    @classmethod
    def predict_next_stage(cls, current_stage: str) -> Dict[str, Any]:
        predictions = cls.TRANSITIONS.get(current_stage, {})
        sorted_preds = sorted(predictions.items(), key=lambda x: x[1], reverse=True)
        
        next_stage = sorted_preds[0][0] if sorted_preds else "Unknown"
        confidence = sorted_preds[0][1] if sorted_preds else 0.0

        return {
            "current_stage": current_stage,
            "next_stage_prediction": next_stage,
            "confidence": confidence,
            "all_probabilities": [{"stage": s, "probability": p} for s, p in sorted_preds]
        }
