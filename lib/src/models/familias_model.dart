class FamiliasModel {
  FamiliasModel({
    this.idFamilia,
    this.nombre,
    this.color,
  });

  String idFamilia;
  String nombre;
  String color;

  factory FamiliasModel.fromJson(Map<String, dynamic> json) => FamiliasModel(
        idFamilia: json["idFamilia"],
        nombre: json["nombre"],
        color: json["color"],
      );
}
