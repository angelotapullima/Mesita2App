class CategoriaModel {
  String idCategoria;
  String categoriaNombre;
  String categoriaEstado;

  CategoriaModel({
    this.idCategoria,
    this.categoriaNombre,
    this.categoriaEstado,
  });

  factory CategoriaModel.fromJson(Map<String, dynamic> json) => CategoriaModel(
        idCategoria: json['idCategoria'],
        categoriaNombre: json['categoriaNombre'],
        categoriaEstado: json['categoriaEstado'],
      );
}
