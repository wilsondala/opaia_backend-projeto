1️⃣ Inserir um carro

INSERT INTO cars (marca, modelo, ano, preco, descricao, imagem_url, dono_id)
VALUES ('Toyota', 'Corolla', 2022, 50000, 'Carro sedan econômico', 'b6f43c22bb9c4ba582934baa391412cb.jpg', 4);

2️⃣ Inserir uma imagem para o carro

INSERT INTO car_images (file_path, car_id)
VALUES ('/uploads/car_do_arquivo.jpg', 1);


3️⃣ Criar um aluguel

INSERT INTO rents (car_id, user_id, start_date, end_date)
VALUES (1, 4, '2025-08-20 09:00:00', '2025-08-25 18:00:00');


4️⃣ Consultar todos os carros

SELECT * FROM cars;

5️⃣ Consultar carros de um usuário específico

SELECT * FROM cars
WHERE dono_id = 4;


6️⃣ Consultar alugueis do usuário logado

SELECT r.id AS aluguel_id, c.marca, c.modelo, r.start_date, r.end_date
FROM rents r
JOIN cars c ON r.car_id = c.id
WHERE r.user_id = 1;
