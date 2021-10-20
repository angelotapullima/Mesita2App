class VentaModel {
  String idVenta;
  String idNegocio;
  String idMesa;
  String idPedido;
  String envio;
  String direccion;
  String tipoDoc;
  String serie;
  String correlativo;
  String igv;
  String incluyeIGV;
  String descuento;
  String total;
  String fecha;
  String hora;
  String estado;

  VentaModel({
    this.idVenta,
    this.idNegocio,
    this.idMesa,
    this.idPedido,
    this.envio,
    this.direccion,
    this.tipoDoc,
    this.serie,
    this.correlativo,
    this.igv,
    this.incluyeIGV,
    this.descuento,
    this.total,
    this.fecha,
    this.hora,
    this.estado,
  });

  factory VentaModel.fromJson(Map<String, dynamic> json) => VentaModel(
        idVenta: json["idVenta"],
        idNegocio: json["idNegocio"],
        idMesa: json["idMesa"],
        idPedido: json["idPedido"],
        envio: json["envio"],
        direccion: json["direccion"],
        tipoDoc: json["tipoDoc"],
        serie: json["serie"],
        correlativo: json["correlativo"],
        igv: json["igv"],
        incluyeIGV: json["incluyeIGV"],
        descuento: json["descuento"],
        total: json["total"],
        fecha: json["fecha"],
        hora: json["hora"],
        estado: json["estado"],
      );
}
