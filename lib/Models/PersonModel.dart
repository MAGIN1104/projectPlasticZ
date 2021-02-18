class PersonaModel {
  PersonaModel({
    this.nombre,
    this.ci,
    this.empresa,
    this.email,
    this.cel,
  });

  String nombre;
  String ci;
  String empresa;
  String email;
  String cel;

  factory PersonaModel.fromJson(Map<String, dynamic> json) => PersonaModel(
        nombre: json["nombre"],
        ci: json["ci"],
        empresa: json["empresa"],
        email: json["email"],
        cel: json["cel"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "ci": ci,
        "empresa": empresa,
        "email": email,
        "cel": cel,
      };
}
