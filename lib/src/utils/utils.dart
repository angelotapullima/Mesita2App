obtenerPrimerNombre(String nombre) {
  if (nombre != '') {
    var separarNombre = nombre.split(' ');
    return '${separarNombre[0]}';
  } else {
    return '';
  }
}
