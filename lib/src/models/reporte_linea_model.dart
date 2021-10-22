class ReporteLineaModel {
  String idLinea;
  String idNegocio;
  String idCategoria;
  String nombre;
  String estado;
  String cantidad;
  String suma;

  ReporteLineaModel({
    this.idLinea,
    this.idNegocio,
    this.idCategoria,
    this.nombre,
    this.estado,
    this.cantidad,
    this.suma,
  });

  factory ReporteLineaModel.fromJson(Map<String, dynamic> json) => ReporteLineaModel(
        idLinea: json["idLinea"],
        idNegocio: json["idNegocio"],
        idCategoria: json["idCategoria"],
        nombre: json["nombre"],
        estado: json["estado"],
        cantidad: json["cantidad"],
        suma: json["suma"],
      );
}
