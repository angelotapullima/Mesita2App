import 'package:flutter/cupertino.dart';

class ItemReportesModel {
  final int id;
  final String item;

  const ItemReportesModel({
    @required this.id,
    @required this.item,
  });
}

const itemsList = [
  ItemReportesModel(id: 1, item: 'General'),
  ItemReportesModel(id: 2, item: 'Categorias'),
  ItemReportesModel(id: 3, item: 'Productos'),
  ItemReportesModel(id: 4, item: 'Utilidades'),
];
