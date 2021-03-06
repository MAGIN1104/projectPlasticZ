class CondicionVentaModel {
  CondicionVentaModel({
    this.formaPago,
    this.lugarEntrega,
    this.tiempoEntrega,
  });
  String formaPago;
  String lugarEntrega;
  String tiempoEntrega;
  factory CondicionVentaModel.fromJson(Map<String, dynamic> json) =>
      CondicionVentaModel(
        formaPago: json["formaPago"],
        lugarEntrega: json["lugarEntrega"],
        tiempoEntrega: json["tiempoEntrega"],
      );
  Map<String, dynamic> toJson() => {
        "formaPago": formaPago,
        "lugarEntrega": lugarEntrega,
        "tiempoEntrega": tiempoEntrega,
      };
}
