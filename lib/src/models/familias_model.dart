class FamiliasModel {
  FamiliasModel({
    this.idFamiliaLocal,
    this.idFamilia,
    this.nombre,
    this.idLocacion,
    this.color,
  });

  String idFamiliaLocal;
  String idFamilia;
  String nombre;
  String idLocacion;
  String color;

  factory FamiliasModel.fromJson(Map<String, dynamic> json) => FamiliasModel(
        idFamiliaLocal: json["idFamiliaLocal"],
        idFamilia: json["idFamilia"],
        nombre: json["nombre"],
        idLocacion: json["idLocacion"],
        color: json["color"],
      );
}
