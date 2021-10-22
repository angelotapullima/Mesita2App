class ReporteGeneralModel {
  String id;
  String cantidad;
  String sumaTotal;

  ReporteGeneralModel({
    this.id,
    this.cantidad,
    this.sumaTotal,
  });

  factory ReporteGeneralModel.fromJson(Map<String, dynamic> json) => ReporteGeneralModel(
        id: json["id"],
        cantidad: json["cantidad"],
        sumaTotal: json["sumaTotal"],
      );
}
