class LineaModel {
  String idLinea;
  String idNegocio;
  String idCategoria;
  String lineaNombre;
  String lineaEstado;

  LineaModel({
    this.idLinea,
    this.idNegocio,
    this.idCategoria,
    this.lineaNombre,
    this.lineaEstado,
  });

  factory LineaModel.fromJson(Map<String, dynamic> json) => LineaModel(
        idLinea: json['idLinea'],
        idNegocio: json['idNegocio'],
        idCategoria: json["idCategoria"],
        lineaNombre: json['lineaNombre'],
        lineaEstado: json['lineaEstado'],
      );
}
