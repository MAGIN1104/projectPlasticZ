import 'dart:convert';

ModeloBolsa modeloBolsaFromJson(String str) =>
    ModeloBolsa.fromJson(json.decode(str));

String modeloBolsaToJson(ModeloBolsa data) => json.encode(data.toJson());

class ModeloBolsa {
  ModeloBolsa({
    this.id,
    this.producto,
    this.tipoProducto,
    this.ancho,
    this.largo,
    this.espesor,
    this.cantidad,
    this.precio,
    this.tkilos,
    this.precioTotal,
    this.precioPorBolsa,
  });

  int id;
  String producto;
  String tipoProducto;
  double ancho;
  double largo;
  double espesor;
  int cantidad;
  double precio;
  double tkilos;
  double precioTotal;
  double precioPorBolsa;

  factory ModeloBolsa.fromJson(Map<String, dynamic> json) => ModeloBolsa(
        id: json["id"],
        producto: json["producto"],
        tipoProducto: json["tipoProducto"],
        ancho: json["ancho"].toDouble(),
        largo: json["largo"].toDouble(),
        espesor: json["espesor"].toDouble(),
        cantidad: json["cantidad"],
        precio: json["precio"].toDouble(),
        tkilos: json["tkilos"].toDouble(),
        precioTotal: json["precioTotal"].toDouble(),
        precioPorBolsa: json["precioPorBolsa"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "producto": producto,
        "tipoProducto": tipoProducto,
        "ancho": ancho,
        "largo": largo,
        "espesor": espesor,
        "cantidad": cantidad,
        "precio": precio,
        "tkilos": tkilos,
        "precioTotal": precioTotal,
        "precioPorBolsa": precioPorBolsa,
      };
  @override
  String toString() {
    return "Bolsas{name $producto, tipoProducto $tipoProducto,ancho $ancho,largo $largo, espesor $espesor, cantidad $cantidad, precio $precio tkilos $tkilos, precioTotal $precioTotal, precioPorBolsa $precioPorBolsa}";
  }
}
