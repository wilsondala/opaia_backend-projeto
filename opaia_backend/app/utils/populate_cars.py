from sqlalchemy.orm import Session
from app.models import User, Car

def criar_usuarios_exemplo(db: Session):
    usuarios = [
        {"full_name": "João Silva", "email": "joao@email.com", "hashed_password": "hashed123"},
        {"full_name": "Maria Souza", "email": "maria@email.com", "hashed_password": "hashed123"},
        {"full_name": "Carlos Pereira", "email": "carlos@email.com", "hashed_password": "hashed123"},
    ]

    usuarios_criados = []
    for u in usuarios:
        existente = db.query(User).filter(User.email == u["email"]).first()
        if not existente:
            novo_usuario = User(
                full_name=u["full_name"],
                email=u["email"],
                hashed_password=u["hashed_password"],
                is_active=True
            )
            db.add(novo_usuario)
            usuarios_criados.append(novo_usuario)

    if usuarios_criados:
        db.commit()
        for usuario in usuarios_criados:
            db.refresh(usuario)

    return db.query(User).filter(User.email.in_([u["email"] for u in usuarios])).all()


def criar_carros_exemplo(db: Session, usuarios: list[User]):
    exemplos = [
        {"modelo": "Civic", "marca": "Honda", "ano": 2020, "dono_id": usuarios[0].id},
        {"modelo": "Corolla", "marca": "Toyota", "ano": 2019, "dono_id": usuarios[0].id},
        {"modelo": "Model S", "marca": "Tesla", "ano": 2022, "dono_id": usuarios[1].id},
        {"modelo": "Gol", "marca": "Volkswagen", "ano": 2018, "dono_id": usuarios[2].id},
    ]

    for carro_data in exemplos:
        existe = db.query(Car).filter(
            Car.modelo == carro_data["modelo"],
            Car.marca == carro_data["marca"],
            Car.ano == carro_data["ano"],
            Car.dono_id == carro_data["dono_id"]
        ).first()

        if not existe:
            novo_carro = Car(**carro_data)
            db.add(novo_carro)

    db.commit()
