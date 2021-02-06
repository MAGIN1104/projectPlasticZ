// To parse this JSON data, do
//
//     final modeloBobina = modeloBobinaFromJson(jsonString);

import 'dart:convert';

ModeloBobina modeloBobinaFromJson(String str) =>
    ModeloBobina.fromJson(json.decode(str));

String modeloBobinaToJson(ModeloBobina data) => json.encode(data.toJson());

class ModeloBobina {
  ModeloBobina({
    this.id,
    this.ancho,
    this.espesor,
    this.cantidad,
    this.tipo,
  });

  int id;
  double ancho;
  double espesor;
  double cantidad;
  bool tipo;

  factory ModeloBobina.fromJson(Map<String, dynamic> json) => ModeloBobina(
        id: json["id"],
        ancho: json["ancho"].toDouble(),
        espesor: json["espesor"].toDouble(),
        cantidad: json["cantidad"].toDouble(),
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ancho": ancho,
        "espesor": espesor,
        "cantidad": cantidad,
        "tipo": tipo,
      };
}
