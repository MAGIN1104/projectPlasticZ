// import 'dart:convert';

// ProductModel productModelFromJson(String str) =>
//     ProductModel.fromJson(json.decode(str));
// String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel(
      {this.id,
      this.producto,
      this.tipoProducto,
      this.color,
      this.ancho,
      this.largo,
      this.espesor,
      this.cantidad,
      this.unidad,
      this.tkilos,
      this.precioUnitario,
      this.precioRollo,
      this.precioTotal});

  int id;
  String producto;
  String tipoProducto;
  String color;
  double ancho;
  double largo;
  double espesor;
  int cantidad;
  String unidad;
  double tkilos;
  double precioUnitario;
  double precioRollo;
  double precioTotal;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        producto: json["producto"],
        tipoProducto: json["tipoProducto"],
        color: json["color"],
        ancho: json["ancho"].toDouble(),
        largo: json["largo"].toDouble(),
        espesor: json["espesor"].toDouble(),
        cantidad: json["cantidad"],
        unidad: json["unidad"],
        tkilos: json["tkilos"].toDouble(),
        precioUnitario: json["precioUnitario"].toDouble(),
        precioRollo: json["precioRollo"].toDouble(),
        precioTotal: json["precioTotal"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "producto": producto,
        "tipoProducto": tipoProducto,
        "color": color,
        "ancho": ancho,
        "largo": largo,
        "espesor": espesor,
        "cantidad": cantidad,
        "unidad": unidad,
        "tkilos": tkilos,
        "precioUnitario": precioUnitario,
        "precioRollo": precioRollo,
        "precioTotal": precioTotal,
      };
}
