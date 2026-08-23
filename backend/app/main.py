from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.routes import graph, prediction, ledger

app = FastAPI(title="CyberShield Ledger API", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(graph.router)
app.include_router(prediction.router)
app.include_router(ledger.router)

@app.get("/")
def read_root():
    return {"system": "CyberShield Ledger Engine Active"}
