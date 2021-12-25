import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

obtenerPrimerNombre(String nombre) {
  if (nombre != '') {
    var separarNombre = nombre.split(' ');
    return separarNombre[0];
  } else {
    return '';
  }
}

obtenerFecha(String date) {
  if (date == 'null' || date == '') {
    return '';
  }

  var fecha = DateTime.parse(date);

  final DateFormat fech = DateFormat('dd MMM', 'es');

  return fech.format(fecha);
}

obtenerRangoFecha(String dateInicio, String dateFin) {
  if ((dateInicio == 'null' || dateInicio == '') && (dateFin == 'null' || dateFin == '')) {
    return '';
  }

  var fecha1 = DateTime.parse(dateInicio);
  var fecha2 = DateTime.parse(dateFin);

  final DateFormat dia = DateFormat('dd', 'es');
  final DateFormat mes = DateFormat('MMMM', 'es');
  final DateFormat mes0 = DateFormat('MMM', 'es');

  var mes1 = mes.format(fecha1);
  var mes2 = mes.format(fecha2);

  if (fecha1.year == fecha2.year) {
    if (mes1 == mes2) {
      return 'del ${dia.format(fecha1)} al ${dia.format(fecha2)} de $mes1, ${fecha1.year} ';
    } else {
      mes1 = mes0.format(fecha1);
      mes2 = mes0.format(fecha2);
      return 'del ${dia.format(fecha1)} $mes1 al ${dia.format(fecha2)} $mes2 ${fecha1.year}';
    }
  } else {
    mes1 = mes0.format(fecha1);
    mes2 = mes0.format(fecha2);
    return 'del ${dia.format(fecha1)} $mes1 ${fecha1.year} al ${dia.format(fecha2)} $mes2 ${fecha2.year}';
  }
}

obtenerFechaActual() {
  var date = DateTime.now();
  final DateFormat fecha = DateFormat('dd MMM yyyy', 'es');

  return fecha.format(date);
}

obtenerFechaFinSuscripcion(int tiempo) {
  var date = DateTime.now();
  final DateFormat fecha = DateFormat('dd MMM yyyy', 'es');
  DateTime fechaRegreso;
  if (tiempo == 7) {
    fechaRegreso = DateTime(date.year, date.month, date.day + tiempo);
  } else {
    fechaRegreso = DateTime(date.year, date.month + tiempo, date.day);
  }

  return fecha.format(fechaRegreso);
}

obtenerFechaActualApi() {
  var date = DateTime.now();
  final DateFormat fecha = DateFormat('yyyy-MM-dd');

  return fecha.format(date);
}

obtenerFechaFinSuscripcionApi(int tiempo) {
  var date = DateTime.now();
  final DateFormat fecha = DateFormat('yyyy-MM-dd');
  DateTime fechaRegreso;
  if (tiempo == 7) {
    fechaRegreso = DateTime(date.year, date.month, date.day + tiempo);
  } else {
    fechaRegreso = DateTime(date.year, date.month + tiempo, date.day);
  }

  return fecha.format(fechaRegreso);
}

void showToast(String texto, Color color) {
  Fluttertoast.showToast(msg: texto, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 3, backgroundColor: color, textColor: Colors.white);
}

showLoading() {
  return Center(
    child: (Platform.isAndroid)
        ? const CircularProgressIndicator(
            color: Color(0XFFFF0036),
          )
        : const CupertinoActivityIndicator(),
  );
}

compararFechaConActual(String fecha) {
  var hoy = DateTime.now();

  var fech = DateTime.parse(fecha);

  var resp = hoy.difference(fech).inDays;

  if (resp >= 0) {
    //Renovar o cambiar de plan

    return true;
  } else {
    //Aún no vence la suscripción actual
    return false;
  }
}

verificarNull(String value) {
  if (value.isNotEmpty && value != 'null') {
    return value;
  } else {
    return '-';
  }
}
