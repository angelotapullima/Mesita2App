class ComandaModel {
  String idMesa;
  String idUsuario;
  String total;
  String token;
  List<DetallePedidoTemporalModel> detalles;

  ComandaModel({
    this.idMesa,
    this.idUsuario,
    this.total,
    this.detalles,
  });

  Map<String, dynamic> toJson() => {
        "id_mesa": idMesa,
        "id_usuario": idUsuario,
        "pedido_total": total,
        "app": 'true',
        "tn": token,
        "detalle": List<dynamic>.from(detalles.map((x) => x.toJson())),
      };
}

class DetallePedidoTemporalModel {
  int id;
  String idMesa;
  String idProducto;
  String foto;
  String nombre;
  String cantidad;
  String subtotal;
  String observaciones;
  String estado;
  String llevar;

  DetallePedidoTemporalModel({
    this.id,
    this.idMesa,
    this.idProducto,
    this.cantidad,
    this.foto,
    this.nombre,
    this.subtotal,
    this.observaciones,
    this.estado,
    this.llevar,
  });

  factory DetallePedidoTemporalModel.fromJson(Map<String, dynamic> json) => DetallePedidoTemporalModel(
        id: json["id"],
        idMesa: json["idMesa"],
        idProducto: json["idProducto"],
        cantidad: json["cantidad"],
        subtotal: json["subtotal"],
        foto: json["foto"],
        nombre: json["nombre"],
        observaciones: json["observaciones"],
        estado: json["estado"],
        llevar: json["llevar"],
      );

  Map<String, dynamic> toJson() => {
        'id_producto': idProducto,
        'pedido_detalle_cantidad': cantidad,
        'pedido_detalle_subtotal': subtotal,
        'pedido_detalle_observaciones': observaciones,
        'pedido_detalle_llevar': llevar,
      };
}
