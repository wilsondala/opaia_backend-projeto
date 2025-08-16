"""initial migration

Revision ID: 0001_initial
Revises: 
Create Date: 2025-08-03 20:00:00.000000

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '0001_initial'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # Tabela users
    op.create_table(
        'users',
        sa.Column('id', sa.Integer, primary_key=True, index=True),
        sa.Column('full_name', sa.String, nullable=True),
        sa.Column('email', sa.String, unique=True, index=True, nullable=False),
        sa.Column('hashed_password', sa.String, nullable=False),
        sa.Column('is_active', sa.Boolean, nullable=False, server_default=sa.true()),
    )

    # Tabela cars
    op.create_table(
        'cars',
        sa.Column('id', sa.Integer, primary_key=True, index=True),
        sa.Column('marca', sa.String, nullable=False),
        sa.Column('modelo', sa.String, nullable=False),
        sa.Column('ano', sa.Integer, nullable=False),
        sa.Column('preco', sa.Float, nullable=True),
        sa.Column('quilometragem', sa.Integer, nullable=True),
        sa.Column('descricao', sa.Text, nullable=True),
        sa.Column('dono_id', sa.Integer, sa.ForeignKey('users.id'), nullable=True),
    )

    # Tabela car_images
    op.create_table(
        'car_images',
        sa.Column('id', sa.Integer, primary_key=True, index=True),
        sa.Column('filename', sa.String, nullable=False),
        sa.Column('url', sa.String, nullable=False),
        sa.Column('car_id', sa.Integer, sa.ForeignKey('cars.id'), nullable=False),
    )


def downgrade():
    op.drop_table('car_images')
    op.drop_table('cars')
    op.drop_table('users')
