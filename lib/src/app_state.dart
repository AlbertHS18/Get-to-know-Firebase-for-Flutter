import 'package:flutter/foundation.dart';

class ApplicationState with ChangeNotifier {
  bool _loggedIn = false; // Estado inicial

  // Getter para acceder a la propiedad
  bool get loggedIn => _loggedIn;

  // Método para actualizar el estado
  void setLoggedIn(bool status) {
    _loggedIn = status;
    notifyListeners(); // Notifica a los widgets que dependen de este estado
  }
}

