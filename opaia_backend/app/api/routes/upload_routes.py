from fastapi import APIRouter, File, UploadFile, HTTPException
import os
import shutil
from uuid import uuid4

router = APIRouter()

UPLOAD_DIR = "uploads"

@router.post("/upload/")
async def upload_image(file: UploadFile = File(...)):
    # Verifica se o diretório uploads existe
    if not os.path.exists(UPLOAD_DIR):
        os.makedirs(UPLOAD_DIR)
    
    # Gera nome único para evitar sobrescrita
    file_ext = os.path.splitext(file.filename)[1]
    unique_filename = f"{uuid4().hex}{file_ext}"
    file_path = os.path.join(UPLOAD_DIR, unique_filename)

    try:
        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao salvar arquivo: {e}")

    # Retorna a URL acessível da imagem
    url = f"/uploads/{unique_filename}"
    return {"filename": unique_filename, "url": url}
