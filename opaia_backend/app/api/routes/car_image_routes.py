from fastapi import APIRouter, UploadFile, File, HTTPException, Depends
from sqlalchemy.orm import Session
from app.database import get_db
from app.models.car import Car
from app.models.car_image import CarImage
import shutil
import uuid
import os

router = APIRouter(tags=["Imagens de Carros"])

UPLOAD_DIR = "uploads"

@router.post("/cars/{car_id}/images/")
async def upload_imagem_carro(
    car_id: int,
    file: UploadFile = File(...),
    db: Session = Depends(get_db)
):
    # Verifica se o carro existe
    carro = db.query(Car).filter(Car.id == car_id).first()
    if not carro:
        raise HTTPException(status_code=404, detail="Carro não encontrado")

    # Gera um nome único para o arquivo mantendo a extensão original
    extensao = os.path.splitext(file.filename)[1]
    nome_unico = f"{uuid.uuid4().hex}{extensao}"

    # Define o caminho completo onde o arquivo será salvo
    caminho_arquivo = os.path.join(UPLOAD_DIR, nome_unico)

    # Salva o arquivo no disco
    with open(caminho_arquivo, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    # Cria o registro da imagem no banco
    imagem_carro = CarImage(
        filename=nome_unico,
        url=f"/uploads/{nome_unico}",
        car_id=car_id
    )
    db.add(imagem_carro)
    db.commit()
    db.refresh(imagem_carro)

    return {
        "id": imagem_carro.id,
        "filename": imagem_carro.filename,
        "url": imagem_carro.url,
        "car_id": imagem_carro.car_id
    }
