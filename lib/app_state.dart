import 'package:cloud_firestore/cloud_firestore.dart'; // Necesario para usar Firestore
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }

  // Aquí se agrega el método para enviar un mensaje al guestbook
  Future<DocumentReference> addMessageToGuestBook(String message) async {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance.collection('guestbook').add({
      'text': message, // El mensaje que el usuario ha dejado
      'timestamp': DateTime.now().millisecondsSinceEpoch, // Marca de tiempo
      'name': FirebaseAuth.instance.currentUser!.displayName, // Nombre del usuario
      'userId': FirebaseAuth.instance.currentUser!.uid, // ID del usuario
    });
  }
}
