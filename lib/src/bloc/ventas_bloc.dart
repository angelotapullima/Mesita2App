import 'package:mesita_aplication_2/src/api/venta_api.dart';
import 'package:mesita_aplication_2/src/database/ventas_database.dart';
import 'package:mesita_aplication_2/src/models/venta_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:rxdart/rxdart.dart';

class VentasBloc {
  final _ventaApi = VentaApi();
  final _ventaDatabase = VentasDatabase();
  final _prefs = Preferences();

  final _ventasController = BehaviorSubject<List<VentaModel>>();
  Stream<List<VentaModel>> get ventasStream => _ventasController.stream;

  void obtenerVentas(bool esHoy) async {
    DateTime hoy = DateTime.now();
    String fech = hoy.toString();
    var dia = fech.split(' ');
    String fecha1;
    String fecha2;

    if (esHoy) {
      fecha1 = dia[0];
      fecha2 = dia[0];
    } else {
      var mes = dia[0].split('-');
      fecha1 = '${mes[0]}-${mes[1]}-01';
      fecha2 = dia[0];
    }

    _ventasController.sink.add(await _ventaDatabase.obtenerVentasPorFecha(_prefs.idNegocio, fecha1, fecha2));
    await _ventaApi.listarVentas(fecha1, fecha2);
    _ventasController.sink.add(await _ventaDatabase.obtenerVentasPorFecha(_prefs.idNegocio, fecha1, fecha2));
  }

  void obtenerVentasPorFecha(String fechaI, String fechaF) async {
    _ventasController.sink.add(null);
    await _ventaApi.listarVentas(fechaI, fechaI);
    _ventasController.sink.add(await _ventaDatabase.obtenerVentasPorFecha(_prefs.idNegocio, fechaI, fechaF));
  }

  dispose() {
    _ventasController?.close();
  }
}
