class DetallePedidoTemporalModel {
  String id;
  String idMesa;
  String idProducto;
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
        observaciones: json["observaciones"],
        estado: json["estado"],
        llevar: json["llevar"],
      );
}
