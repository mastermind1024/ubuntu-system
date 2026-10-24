from http.server import ThreadingHTTPServer, BaseHTTPRequestHandler
from pathlib import Path
from urllib.parse import unquote
import html, os, secrets

PORTA = 8000
MAX_FILE = 2 * 1024**3
CARTELLA = Path.cwd().resolve()
TOKEN = secrets.token_urlsafe(24)

PAGINA = """<!doctype html>
<html lang="it">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Carica file</title>
<style>
body{font-family:system-ui;max-width:650px;margin:40px auto;padding:20px}
main{border:1px solid #bbb;border-radius:12px;padding:24px}
input,button{font-size:16px;margin:8px 0;padding:10px}
button{cursor:pointer}
progress{width:100%;height:24px}
#stato{white-space:pre-wrap;margin-top:15px}
</style>
</head>
<body>
<main>
<h1>Carica file sulla VM</h1>
<p>Seleziona uno o più file. I file esistenti non saranno sovrascritti.</p>
<input id="file" type="file" multiple>
<br>
<button id="carica">Carica</button>
<progress id="barra" value="0" max="100"></progress>
<div id="stato"></div>
</main>
<script>
const files=document.querySelector("#file");
const stato=document.querySelector("#stato");
const barra=document.querySelector("#barra");
document.querySelector("#carica").onclick=async()=>{
  if(!files.files.length){stato.textContent="Seleziona almeno un file.";return;}
  for(const f of files.files){
    stato.textContent="Caricamento: "+f.name;
    barra.value=0;
    await new Promise((resolve)=>{
      const x=new XMLHttpRequest();
      x.open("PUT",location.pathname);
      x.setRequestHeader("X-File-Name",encodeURIComponent(f.name));
      x.upload.onprogress=e=>{if(e.lengthComputable)barra.value=e.loaded/e.total*100};
      x.onload=()=>{stato.textContent+=x.status===201?"\\nCompletato.":"\\nErrore: "+x.responseText;resolve()};
      x.onerror=()=>{stato.textContent+="\\nErrore di connessione.";resolve()};
      x.send(f);
    });
  }
};
</script>
</body>
</html>"""

class Handler(BaseHTTPRequestHandler):
    def autorizzato(self):
        return self.path.split("?", 1)[0] == "/" + TOKEN + "/"

    def do_GET(self):
        if not self.autorizzato():
            self.send_error(404)
            return
        dati = PAGINA.encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(dati)))
        self.end_headers()
        self.wfile.write(dati)

    def do_PUT(self):
        if not self.autorizzato():
            self.send_error(404)
            return

        try:
            lunghezza = int(self.headers.get("Content-Length", "0"))
        except ValueError:
            self.send_error(400, "Dimensione non valida")
            return

        if lunghezza <= 0 or lunghezza > MAX_FILE:
            self.send_error(413, "File vuoto o superiore a 2 GB")
            return

        nome = unquote(self.headers.get("X-File-Name", ""))
        nome = Path(nome).name

        if not nome or nome in (".", ".."):
            self.send_error(400, "Nome file non valido")
            return

        destinazione = CARTELLA / nome
        if destinazione.exists():
            self.send_error(409, "Esiste gia' un file con questo nome")
            return

        temporaneo = CARTELLA / ("." + nome + ".caricamento")

        try:
            rimanenti = lunghezza
            with open(temporaneo, "xb") as f:
                while rimanenti:
                    blocco = self.rfile.read(min(1024 * 1024, rimanenti))
                    if not blocco:
                        raise ConnectionError("Caricamento interrotto")
                    f.write(blocco)
                    rimanenti -= len(blocco)
            os.replace(temporaneo, destinazione)
        except Exception as e:
            temporaneo.unlink(missing_ok=True)
            self.send_error(500, html.escape(str(e)))
            return

        risposta = b"File caricato"
        self.send_response(201)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(risposta)))
        self.end_headers()
        self.wfile.write(risposta)

    def log_message(self, formato, *args):
        print("%s - %s" % (self.client_address[0], formato % args))

print()
print("Cartella di destinazione:", CARTELLA)
print("Apri dal PC:")
print(f"http://128.140.45.133:{PORTA}/{TOKEN}/")
print()
print("Connessione HTTP, non HTTPS.")
print("La porta 8000 deve essere aperta nelle regole OCI.")
print("Non chiudere questo terminale. Premi Ctrl+C per terminare.")
print()

ThreadingHTTPServer(("0.0.0.0", PORTA), Handler).serve_forever()