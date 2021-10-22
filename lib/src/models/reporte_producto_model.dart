class ReporteProductoModel {
  String idProducto;
  String idNegocio;
  String estado;
  String cantidad;
  String suma;

  ReporteProductoModel({
    this.idProducto,
    this.idNegocio,
    this.estado,
    this.cantidad,
    this.suma,
  });

  factory ReporteProductoModel.fromJson(Map<String, dynamic> json) => ReporteProductoModel(
        idProducto: json["idProducto"],
        idNegocio: json["idNegocio"],
        estado: json["estado"],
        cantidad: json["cantidad"],
        suma: json["suma"],
      );
}
