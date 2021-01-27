import 'package:shared_preferences_sample/bloc/authorization_bloc.dart';
import 'package:shared_preferences_sample/model/user.dart';

class HomeBloc {
  User userAuthentite() {
    return authBloc.user;
  }

  logoutUser() {
    authBloc.closeSession();
  }
}
