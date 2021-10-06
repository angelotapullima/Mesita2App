class MesaModel {
  String idMesa;
  String idNegocio;
  String mesaNombre;
  String mesaEstado;

  MesaModel({
    this.idMesa,
    this.idNegocio,
    this.mesaNombre,
    this.mesaEstado,
  });

  factory MesaModel.fromJson(Map<String, dynamic> json) => MesaModel(
        idMesa: json["idMesa"],
        idNegocio: json["idNegocio"],
        mesaNombre: json["mesaNombre"],
        mesaEstado: json["mesaEstado"],
      );
}
