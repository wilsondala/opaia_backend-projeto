"""add rents table

Revision ID: xxxx_add_rents_table
Revises: 0001_initial
Create Date: 2025-08-04 12:00:00.000000
"""
from alembic import op
import sqlalchemy as sa


revision = 'xxxx_add_rents_table'
down_revision = '0001_initial'
branch_labels = None
depends_on = None


def upgrade():
    op.create_table(
        'rents',
        sa.Column('id', sa.Integer, primary_key=True, index=True),
        sa.Column('user_id', sa.Integer, sa.ForeignKey('users.id'), nullable=False),
        sa.Column('car_id', sa.Integer, sa.ForeignKey('cars.id'), nullable=False),
        sa.Column('start_date', sa.Date, nullable=False),
        sa.Column('end_date', sa.Date, nullable=True),
        sa.Column('status', sa.String(length=20), nullable=False, server_default='requested'),
    )


def downgrade():
    op.drop_table('rents')
