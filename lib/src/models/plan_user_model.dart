class PlanUserModel {
  String idUserPlan;
  String idUser;
  String idNegocio;
  String idPlan;
  String inicioFecha;
  String finFecha;
  String voucher;
  String estado;

  PlanUserModel({
    this.idUserPlan,
    this.idUser,
    this.idNegocio,
    this.idPlan,
    this.inicioFecha,
    this.finFecha,
    this.voucher,
    this.estado,
  });

  factory PlanUserModel.fromJson(Map<String, dynamic> json) => PlanUserModel(
        idUserPlan: json["idUserPlan"],
        idUser: json["idUser"],
        idNegocio: json["idNegocio"],
        idPlan: json["idPlan"],
        inicioFecha: json["inicioFecha"],
        finFecha: json["finFecha"],
        voucher: json["voucher"],
        estado: json["estado"],
      );
}
