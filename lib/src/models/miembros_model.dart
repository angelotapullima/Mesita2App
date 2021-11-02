class MiembrosModel {
  String idMiembro;
  String idPlan;
  String idUser;
  String nombre;
  String imagen;
  String apellidoMaterno;
  String apellidoPaterno;
  String puesto;
  String fechaCreacion;
  String estado;

  MiembrosModel({
    this.idMiembro,
    this.idPlan,
    this.idUser,
    this.nombre,
    this.imagen,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.puesto,
    this.fechaCreacion,
    this.estado,
  });

  factory MiembrosModel.fromJson(Map<String, dynamic> json) => MiembrosModel(
        idMiembro: json["idMiembro"],
        idPlan: json["idPlan"],
        idUser: json["idUser"],
        nombre: json["nombre"],
        imagen: json["imagen"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        puesto: json["puesto"],
        fechaCreacion: json["fechaCreacion"],
        estado: json["estado"],
      );
}
