import '../models/accion.dart';

class PilaService {

  final List<Accion> _pila = [];

  void push(String descripcion) {
    _pila.add(Accion(descripcion));
  }

  Accion? pop() {
    if (_pila.isEmpty) return null;
    return _pila.removeLast();
  }

  Accion? peek() {
    if (_pila.isEmpty) return null;
    return _pila.last;
  }

  List<Accion> historial() {
    return List.from(_pila.reversed);
  }

  void clear() {
    _pila.clear();
  }
}