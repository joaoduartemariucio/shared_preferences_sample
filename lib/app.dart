import 'package:flutter/material.dart';
import 'package:shared_preferences_sample/bloc/authorization_bloc.dart';
import 'package:shared_preferences_sample/pages/home_screen.dart';
import 'package:shared_preferences_sample/pages/login_screen.dart';

class SharedPreferencesSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    authBloc.restoreSession();

    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: createContent(),
    );
  }

  createContent() {
    return StreamBuilder<bool>(
        stream: authBloc.isSessionValid,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return HomeScreen();
          }
          return LoginScreen();
        });
  }
}
