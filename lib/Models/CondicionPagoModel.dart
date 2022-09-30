class CondicionPagoModel {
  CondicionPagoModel({
    this.tipoPago,
    this.banco,
    this.numCuenta,
    this.nombre,
    this.descripcion,
  });
  String tipoPago;
  String banco;
  String numCuenta;
  String nombre;
  String descripcion;

  factory CondicionPagoModel.fromJson(Map<String, dynamic> json) =>
      CondicionPagoModel(
        tipoPago: json["tipoPago"],
        banco: json["banco"],
        numCuenta: json["numCuenta"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
      );
  Map<String, dynamic> toJson() => {
        "tipoPago": tipoPago,
        "banco": banco,
        "numCuenta": numCuenta,
        "nombre": nombre,
        "descripcion": descripcion,
      };
}
