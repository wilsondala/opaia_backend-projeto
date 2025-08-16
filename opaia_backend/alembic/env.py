from logging.config import fileConfig
from sqlalchemy import engine_from_config
from sqlalchemy import pool
from alembic import context
import sys
import os

# Adiciona o diretório do projeto ao path para importar módulos app
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

# Importa a metadata do seu Base e os models
from app.db.base_class import Base
from app.models.user import User
from app.models.car import Car
from app.models.car_image import CarImage
from app.models.rent import Rent

# Configuração do arquivo alembic.ini
config = context.config

# Configura logging do Alembic
fileConfig(config.config_file_name)

# MetaData das models que o Alembic vai usar para autogenerate
target_metadata = Base.metadata

def run_migrations_offline():
    url = config.get_main_option("sqlalchemy.url")
    context.configure(
        url=url, target_metadata=target_metadata, literal_binds=True, dialect_opts={"paramstyle": "named"}
    )

    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online():
    connectable = engine_from_config(
        config.get_section(config.config_ini_section), 
        prefix="sqlalchemy.", 
        poolclass=pool.NullPool,
    )

    with connectable.connect() as connection:
        context.configure(connection=connection, target_metadata=target_metadata)

        with context.begin_transaction():
            context.run_migrations()


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
