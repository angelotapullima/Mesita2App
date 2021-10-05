import 'package:flutter/cupertino.dart';

class CategoriaModel {
  final String id;
  final String categoria;
  final String estado;
  final String select;

  const CategoriaModel({
    @required this.id,
    @required this.categoria,
    this.estado,
    this.select,
  });
}

const categoriasList = [
  CategoriaModel(id: '1', categoria: 'Sopas', estado: '1', select: '0'),
  CategoriaModel(id: '2', categoria: 'Ensaladas', estado: '1', select: '0'),
  CategoriaModel(id: '3', categoria: 'Guisos', estado: '1', select: '0'),
];
