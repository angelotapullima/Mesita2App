import 'package:flutter/cupertino.dart';

class FoodModel {
  final String id;
  final String food;
  final String estado;
  final String disponible;
  final String precio;
  final String foto;
  final String descripcion;

  const FoodModel({
    @required this.id,
    @required this.food,
    @required this.disponible,
    @required this.precio,
    this.estado,
    this.foto,
    this.descripcion,
  });
}

const listSopas = [
  FoodModel(
    id: '1',
    food: 'Sopa de res',
    disponible: '0',
    precio: 'S/15.00',
    foto: 'https://cdn.queapetito.com/wp-content/uploads/2019/12/fideos-1-600x469.jpg',
    estado: '1',
    descripcion:
        'Las sopas son una muy buena manera de mejorar los valores nutricionales de los platillos vegetarianos o veganos, ya que aumenta su carga calórica y de grasas, aunque desnaturalice un poco las vitaminas de las verduras.',
  ),
  FoodModel(
    id: '2',
    food: 'Sopa de pollo',
    disponible: '1',
    precio: 'S/15.00',
    foto: 'https://cdn.queapetito.com/wp-content/uploads/2019/12/fideos-1-600x469.jpg',
    estado: '1',
    descripcion:
        'Las sopas son una muy buena manera de mejorar los valores nutricionales de los platillos vegetarianos o veganos, ya que aumenta su carga calórica y de grasas, aunque desnaturalice un poco las vitaminas de las verduras.',
  ),
  FoodModel(
    id: '3',
    food: 'Sopa de majas',
    disponible: '1',
    precio: 'S/15.00',
    foto: 'https://cdn.queapetito.com/wp-content/uploads/2019/12/fideos-1-600x469.jpg',
    estado: '1',
    descripcion:
        'Las sopas son una muy buena manera de mejorar los valores nutricionales de los platillos vegetarianos o veganos, ya que aumenta su carga calórica y de grasas, aunque desnaturalice un poco las vitaminas de las verduras.',
  ),
  FoodModel(
    id: '4',
    food: 'Sopa a la minuta',
    disponible: '0',
    precio: 'S/15.00',
    foto: 'https://cdn.queapetito.com/wp-content/uploads/2019/12/fideos-1-600x469.jpg',
    estado: '1',
    descripcion:
        'Las sopas son una muy buena manera de mejorar los valores nutricionales de los platillos vegetarianos o veganos, ya que aumenta su carga calórica y de grasas, aunque desnaturalice un poco las vitaminas de las verduras.',
  ),
];
