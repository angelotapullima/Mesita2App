class PedidosAtenderModel {
  String idPedidoDetalle;
  String idNegocio;
  String idMesa;
  String idProducto;
  String nombreProducto;
  String mesaNombre;
  String fotoProducto;
  String cantidad;
  String fecha;
  String estado;

  PedidosAtenderModel({
    this.idPedidoDetalle,
    this.idNegocio,
    this.idMesa,
    this.idProducto,
    this.nombreProducto,
    this.mesaNombre,
    this.fotoProducto,
    this.cantidad,
    this.fecha,
    this.estado,
  });

  factory PedidosAtenderModel.fromJson(Map<String, dynamic> json) => PedidosAtenderModel(
        idPedidoDetalle: json["idPedidoDetalle"],
        idNegocio: json["idNegocio"],
        idMesa: json["idMesa"],
        idProducto: json["idProducto"],
        nombreProducto: json["nombreProducto"],
        mesaNombre: json["mesaNombre"],
        fotoProducto: json["fotoProducto"],
        cantidad: json["cantidad"],
        fecha: json["fecha"],
        estado: json["estado"],
      );
}
