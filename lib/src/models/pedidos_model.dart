class PedidoModel {
  String idPedido;
  String idMesa;
  String total;
  String fecha;
  String estado;
  List<DetallePedidoModel> detallesPedido;

  PedidoModel({
    this.idPedido,
    this.total,
    this.idMesa,
    this.fecha,
    this.estado,
    this.detallesPedido,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> json) => PedidoModel(
        idPedido: json["idPedido"],
        total: json["total"],
        idMesa: json["idMesa"],
        fecha: json["fecha"],
        estado: json["estado"],
      );
}

class DetallePedidoModel {
  String idDetalle;
  String idPedido;
  String idProducto;
  String cantidad;
  String subtotal;
  String totalDetalle;
  String observaciones;
  String estado;
  String llevar;
  String nombreProducto;
  String fotoProducto;

  DetallePedidoModel({
    this.idDetalle,
    this.idPedido,
    this.idProducto,
    this.cantidad,
    this.subtotal,
    this.totalDetalle,
    this.observaciones,
    this.estado,
    this.llevar,
    this.nombreProducto,
    this.fotoProducto,
  });

  factory DetallePedidoModel.fromJson(Map<String, dynamic> json) => DetallePedidoModel(
        idDetalle: json["idDetalle"],
        idPedido: json["idPedido"],
        idProducto: json["idProducto"],
        cantidad: json["cantidad"],
        subtotal: json["subtotal"],
        totalDetalle: json["totalDetalle"],
        observaciones: json["observaciones"],
        estado: json["estado"],
        llevar: json["llevar"],
      );
}
