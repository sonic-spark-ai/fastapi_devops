# webhook_server.py
from fastapi import FastAPI, Request, HTTPException
import hmac
import hashlib
import subprocess

app = FastAPI()

# Replace with your secret key from the GitHub webhook settings (if you used one)
GITHUB_SECRET = "your-webhook-secret"

def verify_signature(secret, payload, signature):
    mac = hmac.new(secret.encode(), msg=payload, digestmod=hashlib.sha256)
    return hmac.compare_digest(f"sha256={mac.hexdigest()}", signature)

@app.post("/webhook")
async def webhook(request: Request):
    # Get the GitHub signature from the headers
    signature = request.headers.get("X-Hub-Signature-256")

    # Read the request body
    payload = await request.body()

    # Verify the signature
    if not verify_signature(GITHUB_SECRET, payload, signature):
        raise HTTPException(status_code=401, detail="Invalid signature")

    # Run your deploy script when changes are pushed
    try:
        subprocess.run(["/path/to/deploy.sh"], check=True)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Deploy failed: {e}")

    return {"message": "Webhook received and deploy script triggered."}

# To run this server, execute the following command:
# uvicorn webhook_server:app --host 0.0.0.0 --port 8000
