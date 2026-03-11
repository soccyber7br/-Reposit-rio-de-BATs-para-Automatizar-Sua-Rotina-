# 🖥️ Coleta de Informações do Sistema — Windows 11

Script `.bat` desenvolvido para automatizar a coleta de informações de hardware, rede e segurança de estações Windows, gerando um relatório `.txt` organizado diretamente na área de trabalho do usuário.

Criado por **Analista Renata Scheiner** — White Teams / Controle de Identidade e Conformidade.

---

## 📋 O que o script coleta

| # | Informação | Método |
|---|-----------|--------|
| 1 | Usuário logado | `whoami` |
| 2 | Hostname da máquina | `hostname` |
| 3 | Endereço IP (IPv4) | PowerShell / `Get-NetIPAddress` |
| 4 | Adaptadores de rede, MAC Address e status | `getmac /v /fo list` |
| 5 | Sistema Operacional, modelo do equipamento e data de instalação | PowerShell / `Win32_OperatingSystem` |
| 6 | Versão da BIOS e número de série | PowerShell / `Win32_BIOS` |
| 7 | Modelo do processador | PowerShell / `Win32_Processor` |
| 8 | Memória RAM total (em GB) | PowerShell / `Win32_ComputerSystem` |
| 9 | Tamanho físico do disco (HD/SSD) | PowerShell / `Get-PhysicalDisk` |
| 10 | Status do Windows Defender e data da última atualização de assinatura | PowerShell / `Get-MpComputerStatus` |

---

## 📁 Saída

O relatório é salvo automaticamente na **área de trabalho** do usuário com o nome:

```
info_sistema_NOMEDAMAQUINA.txt
```

---

## ▶️ Como usar

1. Clique com o botão direito no arquivo `info_sistema.bat`
2. Selecione **"Executar como Administrador"**
3. Aguarde a conclusão — o progresso é exibido em tempo real no terminal
4. O arquivo `.txt` será gerado na área de trabalho

> ⚠️ **Requer execução como Administrador** para acessar informações de BIOS, Defender e discos físicos.

---

## 💻 Requisitos

- Windows 10 ou Windows 11
- PowerShell 5.1 ou superior (já incluso no Windows 10/11)
- Permissão de Administrador local

---

## 🔍 Exemplo de saída

```
============================================================
       OUTPUT DE INFORMACOES DO SISTEMA
       White Teams - Controle de Identidade e Conformidade
============================================================
Data/Hora : 10/03/2026 14:32:01
Maquina   : DESKTOP-ABC123

[Usuario Logado]
dominio\renata.scheiner

[Hostname]
DESKTOP-ABC123

[Endereco IP]
192.168.1.105

[Adaptadores de Rede - Nome, MAC e Transporte]
Nome da Conexao:      Wi-Fi
Tipo de Rede:         \Device\Tcpip_{...}
Endereco Fisico:      A1-B2-C3-D4-E5-F6
Status de Transporte: Midia conectada

[Sistema Operacional]
Windows 11 Pro

[Modelo do Sistema]
Dell Latitude 5520

...
```

---

## 🏢 Contexto de uso

Desenvolvido para uso interno na rotina de **inventário e conformidade de ativos**, auxiliando na identificação e registro de estações de trabalho dentro do processo de **Controle de Identidade** da equipe White Teams.

---

*White Teams — Controle de Identidade e Conformidade*
