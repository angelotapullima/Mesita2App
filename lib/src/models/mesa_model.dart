class MesaModel {
  String idMesa;
  String idNegocio;
  String mesaNombre;
  String mesaEstado;
  String mesaCapacidad;

  MesaModel({
    this.idMesa,
    this.idNegocio,
    this.mesaNombre,
    this.mesaEstado,
    this.mesaCapacidad,
  });

  factory MesaModel.fromJson(Map<String, dynamic> json) => MesaModel(
        idMesa: json["idMesa"],
        idNegocio: json["idNegocio"],
        mesaNombre: json["mesaNombre"],
        mesaEstado: json["mesaEstado"],
        mesaCapacidad: json["mesaCapacidad"],
      );
}
