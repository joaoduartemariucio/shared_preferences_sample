import 'package:shared_preferences_sample/bloc/authorization_bloc.dart';

class HomeBloc {
  logoutUser() {
    authBloc.closeSession();
  }
}
