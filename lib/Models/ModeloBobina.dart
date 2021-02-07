import 'dart:convert';

ModeloBobina modeloBobinaFromJson(String str) =>
    ModeloBobina.fromJson(json.decode(str));

String modeloBobinaToJson(ModeloBobina data) => json.encode(data.toJson());

class ModeloBobina {
  ModeloBobina({
    this.id,
    this.producto,
    this.tipoProducto,
    this.ancho,
    this.espesor,
    this.cantidad,
    this.precio,
    this.tkilosPorRollo,
    this.precioTotal,
    this.precioPorMetro,
  });

  int id;
  String producto;
  String tipoProducto;
  double ancho;
  double espesor;
  int cantidad;
  double precio;
  double tkilosPorRollo;
  double precioTotal;
  double precioPorMetro;

  factory ModeloBobina.fromJson(Map<String, dynamic> json) => ModeloBobina(
        id: json["id"],
        producto: json["producto"],
        tipoProducto: json["tipoProducto"],
        ancho: json["ancho"].toDouble(),
        espesor: json["espesor"].toDouble(),
        cantidad: json["cantidad"],
        precio: json["precio"].toDouble(),
        tkilosPorRollo: json["tkilosPorRollo"].toDouble(),
        precioTotal: json["precioTotal"].toDouble(),
        precioPorMetro: json["precioPorMetro"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "producto": producto,
        "tipoProducto": tipoProducto,
        "ancho": ancho,
        "espesor": espesor,
        "cantidad": cantidad,
        "precio": precio,
        "tkilosPorRollo": tkilosPorRollo,
        "precioTotal": precioTotal,
        "precioPorMetro": precioPorMetro,
      };
  @override
  String toString() {
    return "Bobina{name $producto, tipoProducto $tipoProducto,ancho $ancho,largo, espesor $espesor, cantidad $cantidad, precio $precio tkilos $tkilosPorRollo, precioTotal $precioTotal, precioPorBolsa $precioPorMetro}";
  }
}
