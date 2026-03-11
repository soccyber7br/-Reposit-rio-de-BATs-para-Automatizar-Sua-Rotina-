@echo off
setlocal

REM ============================================================
REM  COLETA DE INFORMACOES DO SISTEMA
REM  Criado por Analista Renata Scheiner 
REM ============================================================

color 1F
title White Teams ^| Coleta de Informacoes do Sistema

REM Obter caminho da area de trabalho
for /f "tokens=2,*" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v Desktop 2^>nul') do set DesktopPath=%%b
set "OUTPUT=%DesktopPath%\info_sistema_%COMPUTERNAME%.txt"

cls
echo.
echo  +======================================================+
echo  ^|   TEAM INFRA  -  Controle de Identidade             ^|
echo  ^|        Coleta de Informacoes do Sistema              ^|
echo  +======================================================+
echo.
echo   Maquina  : %COMPUTERNAME%
echo   Usuario  : %USERNAME%
echo   Data     : %date%   Hora: %time:~0,8%
echo.
echo  ------------------------------------------------------
echo   Por favor, aguarde. NAO feche esta janela!
echo  ------------------------------------------------------
echo.

REM ── Criar cabecalho do arquivo ──────────────────────────────
(
echo ============================================================
echo        OUTPUT DE INFORMACOES DO SISTEMA
echo        White Teams - Controle de Identidade e Conformidade
echo ============================================================
echo Data/Hora : %date% %time%
echo Maquina   : %COMPUTERNAME%
echo.
) > "%OUTPUT%"

REM ── [1/10] Usuario Logado ───────────────────────────────────
echo   [ 1 / 10 ]  Usuario logado...
(
echo [Usuario Logado]
whoami
echo.
) >> "%OUTPUT%"
echo              OK!
echo.

REM ── [2/10] Hostname ─────────────────────────────────────────
echo   [ 2 / 10 ]  Hostname...
(
echo [Hostname]
hostname
echo.
) >> "%OUTPUT%"
echo              OK!
echo.

REM ── [3/10] Endereco IP ──────────────────────────────────────
echo   [ 3 / 10 ]  Endereco IP...
echo [Endereco IP] >> "%OUTPUT%"
powershell -Command "(Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' -and $_.PrefixOrigin -ne 'WellKnown' }).IPAddress" >> "%OUTPUT%"
echo. >> "%OUTPUT%"
echo              OK!
echo.

REM ── [4/10] Adaptadores de Rede ──────────────────────────────
echo   [ 4 / 10 ]  Adaptadores de rede e MAC Address...
echo [Adaptadores de Rede - Nome e MAC Address] >> "%OUTPUT%"
powershell -Command "Get-NetAdapter | Select-Object -Property Name, MacAddress | Format-Table -AutoSize" >> "%OUTPUT%"
echo. >> "%OUTPUT%"
echo              OK!
echo.

REM ── [5/10] Sistema Operacional ──────────────────────────────
echo   [ 5 / 10 ]  Sistema Operacional e modelo...
echo [Sistema Operacional] >> "%OUTPUT%"
powershell -Command "(Get-CimInstance Win32_OperatingSystem).Caption" >> "%OUTPUT%"
echo. >> "%OUTPUT%"
echo [Modelo do Sistema] >> "%OUTPUT%"
powershell -Command "(Get-CimInstance Win32_ComputerSystem).Model" >> "%OUTPUT%"
echo. >> "%OUTPUT%"
echo [Data de Instalacao do Sistema] >> "%OUTPUT%"
powershell -Command "(Get-CimInstance Win32_OperatingSystem).InstallDate | Get-Date -Format 'dd/MM/yyyy'" >> "%OUTPUT%"
echo. >> "%OUTPUT%"
echo              OK!
echo.

REM ── [6/10] BIOS ─────────────────────────────────────────────
echo   [ 6 / 10 ]  Informacoes da BIOS...
echo [Versao da BIOS] >> "%OUTPUT%"
powershell -Command "(Get-CimInstance Win32_BIOS).SMBIOSBIOSVersion" >> "%OUTPUT%"
echo. >> "%OUTPUT%"
echo [Numero de Serie da BIOS] >> "%OUTPUT%"
powershell -Command "(Get-CimInstance Win32_BIOS).SerialNumber" >> "%OUTPUT%"
echo. >> "%OUTPUT%"
echo              OK!
echo.

REM ── [7/10] Processador ──────────────────────────────────────
echo   [ 7 / 10 ]  Processador...
echo [Modelo do Processador] >> "%OUTPUT%"
powershell -Command "(Get-CimInstance Win32_Processor).Name" >> "%OUTPUT%"
echo. >> "%OUTPUT%"
echo              OK!
echo.

REM ── [8/10] Memoria RAM ──────────────────────────────────────
echo   [ 8 / 10 ]  Memoria RAM...
echo [Memoria RAM Total] >> "%OUTPUT%"
powershell -Command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2).ToString() + ' GB'" >> "%OUTPUT%"
echo. >> "%OUTPUT%"
echo              OK!
echo.

REM ── [9/10] HD Fisico ────────────────────────────────────────
echo   [ 9 / 10 ]  Disco fisico...
echo [Tamanho Fisico do HD] >> "%OUTPUT%"
powershell -Command "(Get-PhysicalDisk | Select-Object -ExpandProperty Size) | ForEach-Object { [math]::Round($_ / 1GB, 2).ToString() + ' GB' }" >> "%OUTPUT%"
echo. >> "%OUTPUT%"
echo              OK!
echo.

REM ── [10/10] Windows Defender ────────────────────────────────
echo   [ 10 / 10 ] Windows Defender...
echo [Status do Windows Defender] >> "%OUTPUT%"
powershell -Command "Get-MpComputerStatus | Select-Object -Property AMServiceEnabled, AntispywareEnabled, AntivirusEnabled, RealTimeProtectionEnabled, BehaviorMonitorEnabled, IoavProtectionEnabled, IsTamperProtected | Format-List" >> "%OUTPUT%"
echo. >> "%OUTPUT%"
echo [Data da Ultima Atualizacao do Antivirus - Defender] >> "%OUTPUT%"
powershell -Command "$OutputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8; (Get-MpComputerStatus).AntivirusSignatureLastUpdated" >> "%OUTPUT%"
echo. >> "%OUTPUT%"
echo              OK!
echo.

REM ── Assinatura no arquivo ───────────────────────────────────
(
echo.
echo ------------------------------------------------------------
echo  Criado por Analista Renata Scheiner
echo  White Teams - Controle de Identidade e Conformidade
echo ------------------------------------------------------------
) >> "%OUTPUT%"

REM ── Tela final ──────────────────────────────────────────────
cls
echo.
echo  +======================================================+
echo  ^|        WHITE TEAMS  -  Coleta Concluida!             ^|
echo  +======================================================+
echo.
echo   [OK]  Usuario logado
echo   [OK]  Hostname
echo   [OK]  Endereco IP e Adaptadores de Rede
echo   [OK]  Sistema Operacional e Modelo
echo   [OK]  BIOS e Numero de Serie
echo   [OK]  Processador
echo   [OK]  Memoria RAM
echo   [OK]  Disco Fisico
echo   [OK]  Windows Defender
echo.
echo  ------------------------------------------------------
echo   Relatorio salvo em:
echo   %OUTPUT%
echo  ------------------------------------------------------
echo.
echo   IMPORTANTE: Nao esqueca de preencher a planilha!
echo   Controle de Identidade e Conformidade - White Teams
echo.
echo  ------------------------------------------------------
echo   Voce ja pode fechar esta janela.
echo  ------------------------------------------------------
echo.
pause
