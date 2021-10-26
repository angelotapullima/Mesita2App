class ProductoLineaModel {
  String idProducto;
  String idLinea;
  String productoNombre;
  String productoDescripcion;
  String productoFoto;
  String productoPrecio;
  String productoEstado;
  String productoCocina;
  String productoCosto;

  ProductoLineaModel({
    this.idProducto,
    this.idLinea,
    this.productoNombre,
    this.productoDescripcion,
    this.productoFoto,
    this.productoPrecio,
    this.productoEstado,
    this.productoCocina,
    this.productoCosto,
  });

  factory ProductoLineaModel.fromJson(Map<String, dynamic> json) => ProductoLineaModel(
        idProducto: json['idProducto'],
        idLinea: json['idLinea'],
        productoNombre: json['productoNombre'],
        productoDescripcion: json['productoDescripcion'],
        productoFoto: json['productoFoto'],
        productoPrecio: json['productoPrecio'],
        productoEstado: json['productoEstado'],
        productoCosto: json["productoCosto"],
      );
}
