Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "📁 SIMULATING FILE INGRESS & ARTIFACT INGESTION (SAFE BENIGN TEST)" -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan

$inbox = "$PWD\test_inbox"
if (!(Test-Path $inbox)) {
    New-Item -ItemType Directory -Path $inbox | Out-Null
}

# 1. Benign Text Document
Write-Host "`n[1/3] Generating Standard Plaintext Document..." -ForegroundColor Yellow
$cleanPath = "$inbox\quarterly_financial_report.txt"
"Fiscal Year 2026 Summary: Operational baseline nominal. All systems secure." | Out-File -FilePath $cleanPath -Encoding utf8
Write-Host "  Created: $cleanPath (Score: Nominal 0%)" -ForegroundColor Green

# 2. Mock Suspicious Macro Document (Safe Plaintext Representation)
Write-Host "`n[2/3] Generating Mock Macro-Enabled Document Simulation..." -ForegroundColor Yellow
$macroPath = "$inbox\invoice_macro_attached.docm"
"MOCK_MACRO_HEADER: AutoOpen_Payload_Stub [BENIGN_TEST_MARKER]" | Out-File -FilePath $macroPath -Encoding utf8
Write-Host "  Created: $macroPath (Simulated Suspicious Macro Extension)" -ForegroundColor Magenta

# 3. Mock Obfuscated Script Artifact
Write-Host "`n[3/3] Generating Mock Script Ingress Artifact..." -ForegroundColor Yellow
$scriptPath = "$inbox\update_agent_stager.vbs"
"' Mock VBScript stager signature simulation for scanner verification" | Out-File -FilePath $scriptPath -Encoding utf8
Write-Host "  Created: $scriptPath (Simulated Script Vector)" -ForegroundColor Magenta

# 4. Ingest Telemetry to FastAPI Backend
Write-Host "`n[Ingestion] Pushing Telemetry to SOC Dashboard..." -ForegroundColor Cyan

$telemetry = @{
    event_id     = [Guid]::NewGuid().ToString()
    timestamp    = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    event_type   = "FILE_INGRESS_SCAN_TRIGGERED"
    user         = $env:USERNAME
    source_host  = "PERIMETER-EMAIL-GATEWAY"
    target_host  = "LOCAL-ENDPOINT-CORE"
    process_name = "file_scanner.py"
    command      = "SCAN_DIRECTORY: $inbox"
    threat_score = 85
    mitre_tactic = "TA0001 - Initial Access (Spearphishing Attachment)"
    raw_message  = "Suspicious mock macro and script artifacts detected in ingress inbox"
} | ConvertTo-Json

try {
    $res = Invoke-RestMethod -Uri "http://127.0.0.1:8000/api/v1/ingest" -Method Post -Body $telemetry -ContentType "application/json" -ErrorAction SilentlyContinue
    if ($res) {
        Write-Host "  Merkle Root Updated: $($res.merkle_root.Substring(0, 18))..." -ForegroundColor Cyan
    }
} catch {
    Write-Host "  FastAPI Backend Offline — Ensure port 8000 is active." -ForegroundColor DarkGray
}

Write-Host "`n✅ Safe File Simulation Complete. Check the SOC Dashboard." -ForegroundColor Green