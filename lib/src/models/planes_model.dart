class PlanesModel {
  String idPlan;
  String nombre;
  String descripcion;
  String costo;
  String estado;

  PlanesModel({
    this.idPlan,
    this.nombre,
    this.descripcion,
    this.costo,
    this.estado,
  });

  factory PlanesModel.fromJson(Map<String, dynamic> json) => PlanesModel(
        idPlan: json["idPlan"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        costo: json["costo"],
        estado: json["estado"],
      );
}
