class Car {
  final int id;
  final String marca;
  final String modelo;
  final int ano;
  final double preco;
  final String descricao;
  final String? imagemUrl;
  final int donoId;

  Car({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.ano,
    required this.preco,
    required this.descricao,
    this.imagemUrl,
    required this.donoId,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      marca: json['marca'],
      modelo: json['modelo'],
      ano: json['ano'],
      preco: json['preco'].toDouble(),
      descricao: json['descricao'],
      imagemUrl: json['imagem_url'],
      donoId: json['dono_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'ano': ano,
      'preco': preco,
      'descricao': descricao,
      'imagem_url': imagemUrl,
      'dono_id': donoId,
    };
  }
}
