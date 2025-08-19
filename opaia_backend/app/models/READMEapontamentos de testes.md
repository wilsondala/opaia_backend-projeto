curl -X POST "http://localhost:8000/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "full_name": "Wilson Teste",
    "email": "wilson.teste@example.com",
    "password": "12345678"
  }'






1️⃣ Criar um carro

curl -X POST "http://localhost:8000/cars/" \
-H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwiZXhwIjoxNzU1NjExMDUzfQ.V2oamq5Ea1XwZnHzM6TGmzM8ZNv78IIWPYJ79p-SFoM" \
-H "Content-Type: application/json" \
-d '{
  "marca": "Nissan",
  "modelo": "kicks",
  "ano": 2022,
  "preco": 50000,
  "descricao": "Carro sedan econômico",
  "imagem_url": "b6f43c22bb9c4ba582934baa391412cb.jpg"
}'


2️⃣ Listar todos os carros

curl -X GET "http://localhost:8000/cars/" \
-H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwiZXhwIjoxNzU1NjExMDUzfQ.V2oamq5Ea1XwZnHzM6TGmzM8ZNv78IIWPYJ79p-SFoM"


3️⃣ Listar meus carros

curl -X GET "http://localhost:8000/cars/meus" \
-H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwiZXhwIjoxNzU1NjExMDUzfQ.V2oamq5Ea1XwZnHzM6TGmzM8ZNv78IIWPYJ79p-SFoM"

4️⃣ Filtrar carros por marca, ano ou preço

curl -X GET "http://localhost:8000/cars/?marca=Toyota&ano_min=2020&preco_max=60000" \
-H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwiZXhwIjoxNzU1NjExMDUzfQ.V2oamq5Ea1XwZnHzM6TGmzM8ZNv78IIWPYJ79p-SFoM"

5️⃣ Criar um aluguel

curl -X POST "http://localhost:8000/rents/" \
-H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwiZXhwIjoxNzU1NjExMDUzfQ.V2oamq5Ea1XwZnHzM6TGmzM8ZNv78IIWPYJ79p-SFoM" \
-H "Content-Type: application/json" \
-d '{
  "car_id": 1,
  "data_inicio": "2025-08-20",
  "data_fim": "2025-08-25"
}'


6️⃣ Listar todos os alugueis

curl -X GET "http://localhost:8000/rents/" \
-H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwiZXhwIjoxNzU1NjExMDUzfQ.V2oamq5Ea1XwZnHzM6TGmzM8ZNv78IIWPYJ79p-SFoM"

7️⃣ Upload de imagem para um carro


curl -X POST "http://localhost:8000/car-images/" \
-H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0IiwiZXhwIjoxNzU1NjExMDUzfQ.V2oamq5Ea1XwZnHzM6TGmzM8ZNv78IIWPYJ79p-SFoM" \
-F "car_id=1" \
-F "file=@/home/ndembuza/opaia_backend-projeto/opaia_backend/uploads/car_do_arquivo.jpg"
