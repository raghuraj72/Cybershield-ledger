from fastapi import APIRouter
from app.services.graph.graph_builder import TemporalAttackGraph

router = APIRouter(prefix="/graph", tags=["Attack Graph"])

@router.get("/active-campaign")
async def get_active_attack_graph():
    builder = TemporalAttackGraph()
    # Dummy event injection for visualization
    builder.add_telemetry_event({
        "timestamp": "2026-08-24T10:00:00Z",
        "event_type": "process_execution",
        "entities": {"user": "admin", "host_src": "10.0.0.1", "process_name": "powershell.exe"}
    })
    return {"status": "success", "graph_data": builder.export_cytoscape_format()}
