#!/usr/bin/env bash
# Pagina web per scaricare i file della cartella corrente (solo via tunnel SSH)
set -euo pipefail
PORTA="${1:-8000}"
DIR="$(pwd)"

case "$PORTA" in ''|*[!0-9]*) echo "Porta non valida: $PORTA"; exit 1;; esac
command -v python3 >/dev/null || { echo "python3 non trovato"; exit 1; }
if ss -ltn | awk '{print $4}' | grep -q ":$PORTA$"; then
  echo "La porta $PORTA è già in uso. Usa: condividi ALTRA_PORTA"; exit 1
fi

IP="$(curl -s --max-time 3 https://ifconfig.me || true)"
[ -n "$IP" ] || IP="IP_DELLA_VM"

echo "============================================================"
echo " CONDIVISIONE ATTIVA su $(hostname)"
echo " Cartella: $DIR"
echo " Server in ascolto SOLO su 127.0.0.1:$PORTA (non esposto su internet)"
echo "============================================================"
echo " Sul PC Windows apri PowerShell e incolla:"
echo
echo "Start-Job { Start-Sleep 4; Start-Process 'http://localhost:$PORTA' } | Out-Null; ssh -o ServerAliveInterval=100 -N -L ${PORTA}:127.0.0.1:${PORTA} ubuntu@$IP"
echo
echo " Il browser si apre da solo. Per chiudere: Ctrl+C qui e in PowerShell."
echo "============================================================"
exec python3 -m http.server "$PORTA" --bind 127.0.0.1 --directory "$DIR"
