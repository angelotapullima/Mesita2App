class MesaModel {
  String idMesa;
  String idNegocio;
  String mesaNombre;
  String mesaEstado;
  String mesaCapacidad;
  String mesaTipo;

  MesaModel({
    this.idMesa,
    this.idNegocio,
    this.mesaNombre,
    this.mesaEstado,
    this.mesaCapacidad,
    this.mesaTipo,
  });

  factory MesaModel.fromJson(Map<String, dynamic> json) => MesaModel(
        idMesa: json["idMesa"],
        idNegocio: json["idNegocio"],
        mesaNombre: json["mesaNombre"],
        mesaEstado: json["mesaEstado"],
        mesaCapacidad: json["mesaCapacidad"],
        mesaTipo: json["mesaTipo"],
      );
}
