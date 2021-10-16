class AgreparProductoPedidoModel {
  String idPedido;
  String token;
  List<DetalleProductoModel> detalles;

  AgreparProductoPedidoModel({
    this.idPedido,
    this.detalles,
    this.token,
  });

  Map<String, dynamic> toJson() => {
        'app': 'true',
        'tn': token,
        'id_mesa': idPedido,
        'detalle': List<dynamic>.from(detalles.map((x) => x.toJson())),
      };
}

class DetalleProductoModel {
  String idProducto;
  String cantidad;
  String subtotal;
  String observaciones;
  String llevar;

  DetalleProductoModel({
    this.idProducto,
    this.cantidad,
    this.subtotal,
    this.observaciones,
    this.llevar,
  });

  Map<String, dynamic> toJson() => {
        'id_producto': idProducto,
        'pedido_detalle_cantidad': cantidad,
        'pedido_detalle_subtotal': subtotal,
        'pedido_detalle_observaciones': observaciones,
        'pedido_detalle_llevar': llevar,
      };
}
