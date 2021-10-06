class LineaModel {
  String idLinea;
  String idNegocio;
  String lineaNombre;
  String lineaEstado;

  LineaModel({
    this.idLinea,
    this.idNegocio,
    this.lineaNombre,
    this.lineaEstado,
  });

  factory LineaModel.fromJson(Map<String, dynamic> json) => LineaModel(
        idLinea: json['idLinea'],
        idNegocio: json['idNegocio'],
        lineaNombre: json['lineaNombre'],
        lineaEstado: json['lineaEstado'],
      );
}
