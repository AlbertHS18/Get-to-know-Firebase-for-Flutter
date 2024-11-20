import 'package:firebase_auth/firebase_auth.dart'; // nuevo, corregido
import 'package:flutter/material.dart';           // nuevo
import 'package:provider/provider.dart';          // nuevo

import 'app_state.dart';                          // nuevo
import 'src/authentication.dart';                 // nuevo
import 'src/widgets.dart';
import 'guest_book.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Meetup'),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('assets/codelab.png'),
          const SizedBox(height: 8),
          const IconAndDetail(Icons.calendar_today, 'October 30'),
          const IconAndDetail(Icons.location_city, 'San Francisco'),
          // Consumer widget to handle state changes
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
              loggedIn: appState.loggedIn,
              signOut: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header("What we'll be doing"),
          const Paragraph(
            'Join us for a day full of Firebase Workshops and Pizza!',
          ),
          // Add the following two lines.
          const Header('Discussion'),
          // Aquí se llama al método `addMessage` de `ApplicationState`
          Consumer<ApplicationState>(
            builder: (context, appState, _) => GuestBook(
              addMessage: (message) async {
                await appState.addMessageToGuestBook(message);
              },
            ),
          ),
        ],
      ),
    );
  }
}
