class ReporteUtilidadesLineaModel {
  String idLinea;
  String idNegocio;
  String idCategoria;
  String nombre;
  String estado;
  String cantidad;
  String suma;

  ReporteUtilidadesLineaModel({
    this.idLinea,
    this.idNegocio,
    this.idCategoria,
    this.nombre,
    this.estado,
    this.cantidad,
    this.suma,
  });

  factory ReporteUtilidadesLineaModel.fromJson(Map<String, dynamic> json) => ReporteUtilidadesLineaModel(
        idLinea: json["idLinea"],
        idNegocio: json["idNegocio"],
        idCategoria: json["idCategoria"],
        nombre: json["nombre"],
        estado: json["estado"],
        cantidad: json["cantidad"],
        suma: json["suma"],
      );
}
