import 'package:rxdart/rxdart.dart';

class Bloc {
  final _idUserController = BehaviorSubject<String>();
  final _nombreController = BehaviorSubject<String>();

  Stream<String> get idStream => _idUserController.stream;
  Stream<String> get nombreStream => _nombreController.stream;

  Function(String) get changeId => _idUserController.sink.add;
  Function(String) get changeName => _nombreController.sink.add;

  String get id => _idUserController.value;
  String get name => _nombreController.value;

  dispose() {
    _idUserController?.close();
    _nombreController?.close();
  }
}
