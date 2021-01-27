import 'package:flutter/material.dart';
import 'package:shared_preferences_sample/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  HomeBloc bloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "E-mail: ${bloc.userAuthentite().email}",
            style: TextStyle(color: Colors.black),
          )),
          Center(
              child: Text(
            "Token: ${bloc.userAuthentite().token}",
            style: TextStyle(color: Colors.black),
          )),
          Center(
            child: RaisedButton(
              onPressed: bloc.logoutUser,
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
