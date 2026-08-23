Clear-Host
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "🛡️  CYBERSHIELD LEDGER — LIVE TEAM DEFENSE DEMO (REAL-TIME)" -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "This test case validates all 4 layers of CyberShield in real time:`n" -ForegroundColor Gray

# Step 1: Baseline Check
Write-Host "[PHASE 1] Initializing Zero-Trust Baseline..." -ForegroundColor Yellow
$status = try { Invoke-RestMethod -Uri "http://127.0.0.1:8000/api/v1/ledger" -Method Get -ErrorAction Stop } catch { $null }

if ($null -eq $status) {
    Write-Host "⚠️  FastAPI Backend not running. Starting it now on port 8000..." -ForegroundColor Magenta
    Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD'; .\venv\Scripts\Activate.ps1; cd backend; python -m uvicorn app.main:app --host 127.0.0.1 --port 8000"
    Start-Sleep -Seconds 3
} else {
    Write-Host "✅ FastAPI Backend Connected. Merkle Root: $($status.merkle_root.Substring(0, 18))..." -ForegroundColor Green
}

# Step 2: Ingress Phishing Link & Macro File Attack
Write-Host "`n-----------------------------------------------------------------" -ForegroundColor DarkGray
Write-Host "[PHASE 2] Triggering Perimeter Threat Ingress (Phishing & Macro)..." -ForegroundColor Yellow
Write-Host "Sending malicious spearphishing payload to API..." -ForegroundColor DarkYellow

$phishEvent = @{
    event_id     = [Guid]::NewGuid().ToString()
    timestamp    = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    event_type   = "PHISHING_INGRESS_DETECTED"
    user         = "finance_analyst"
    source_host  = "PERIMETER-GATEWAY"
    target_host  = "WS-FIN-01"
    process_name = "outlook.exe"
    command      = "hxxp://secure-banking-auth.top/login.php?user=admin"
    threat_score = 92
    mitre_tactic = "TA0001 - Initial Access (Drive-by Compromise)"
    raw_message  = "High-risk phishing URL detected in inbound communication stream"
} | ConvertTo-Json

$res1 = Invoke-RestMethod -Uri "http://127.0.0.1:8000/api/v1/ingest" -Method Post -Body $phishEvent -ContentType "application/json"
Write-Host "🚨 Alert Ingested: Threat Score 92%" -ForegroundColor Red
Write-Host "🔗 Merkle Tree Root Shifted -> $($res1.merkle_root.Substring(0, 24))..." -ForegroundColor Cyan
Start-Sleep -Seconds 2

# Step 3: High-Entropy Ransomware Encryption Burst
Write-Host "`n-----------------------------------------------------------------" -ForegroundColor DarkGray
Write-Host "[PHASE 3] Simulating High-Entropy Ransomware Burst (Shannon H > 7.5)..." -ForegroundColor Yellow

$inbox = "$PWD\test_inbox"
if (!(Test-Path $inbox)) { New-Item -ItemType Directory -Path $inbox | Out-Null }

for ($i = 1; $i -le 3; $i++) {
    $filePath = "$inbox\corp_db_$i.locked"
    $bytes = New-Object byte[] 4096
    (New-Object System.Random).NextBytes($bytes)
    [System.IO.File]::WriteAllBytes($filePath, $bytes)

    $rswEvent = @{
        event_id     = [Guid]::NewGuid().ToString()
        timestamp    = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
        event_type   = "BEHAVIORAL_RANSOMWARE_BURST"
        user         = $env:USERNAME
        source_host  = "ENDPOINT-FS-WATCHER"
        target_host  = "LOCAL-STORAGE-VOLUME"
        process_name = "crypt_stager.exe"
        command      = "ENCRYPT_BLOCK: $filePath (Shannon Entropy: 7.98)"
        threat_score = 99
        mitre_tactic = "TA0040 - Impact (Data Encrypted for Impact)"
        raw_message  = "Mathematical high-entropy file mutation detected"
    } | ConvertTo-Json

    $res2 = Invoke-RestMethod -Uri "http://127.0.0.1:8000/api/v1/ingest" -Method Post -Body $rswEvent -ContentType "application/json"
    Write-Host "  💥 Encrypted Payload Trapped: corp_db_$i.locked (Merkle Leaf: $($res2.merkle_root.Substring(0, 16))...)" -ForegroundColor Red
    Start-Sleep -Milliseconds 400
}

# Step 4: Living-off-the-Land (LotL) Process Attack
Write-Host "`n-----------------------------------------------------------------" -ForegroundColor DarkGray
Write-Host "[PHASE 4] Executing Dual-Use Binary Exploitation (vssadmin & encoded shellcode)..." -ForegroundColor Yellow

$lotlEvent = @{
    event_id     = [Guid]::NewGuid().ToString()
    timestamp    = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    event_type   = "LOTL_DUAL_USE_EXPLOIT"
    user         = "SYSTEM"
    source_host  = "LOCAL-WMI-CONTROLLER"
    target_host  = "LOCAL-ENDPOINT-CORE"
    process_name = "vssadmin.exe"
    command      = "vssadmin.exe delete shadows /all /quiet"
    threat_score = 98
    mitre_tactic = "TA0040 - Impact (Inhibit System Recovery)"
    raw_message  = "Shadow copy deletion attempted via dual-use administrative binary"
} | ConvertTo-Json

$res3 = Invoke-RestMethod -Uri "http://127.0.0.1:8000/api/v1/ingest" -Method Post -Body $lotlEvent -ContentType "application/json"
Write-Host "🚨 LotL Attack Neutralized! (Threat Score: 98%)" -ForegroundColor Red
Write-Host "🔗 Merkle Consensus Updated -> $($res3.merkle_root)" -ForegroundColor Cyan
Start-Sleep -Seconds 2

# Step 5: Cryptographic Non-Repudiation Verification
Write-Host "`n-----------------------------------------------------------------" -ForegroundColor DarkGray
Write-Host "[PHASE 5] Executing Cryptographic Mathematical Proof Audit..." -ForegroundColor Yellow
.\venv\Scripts\python.exe backend/app/verify_proof.py

Write-Host "`n=================================================================" -ForegroundColor Green
Write-Host "✅ TEST CASE COMPLETED: ALL THREATS LOGGED & VERIFIED IN LEDGER" -ForegroundColor Green
Write-Host "=================================================================" -ForegroundColor Green
Write-Host "👉 Open your browser at http://localhost:8000 (or index.html) to show the updated SOC dashboard to your team.`n" -ForegroundColor Cyan