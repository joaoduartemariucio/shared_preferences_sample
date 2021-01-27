import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_sample/model/user.dart';
import 'package:shared_preferences_sample/provider/shared_provider.dart';

class AuthorizationBloc {
  User user;

  final PublishSubject _isSessionValid = PublishSubject<bool>();
  Stream<bool> get isSessionValid => _isSessionValid.stream;
  SharedPref sharedPref = SharedPref();

  void dispose() {
    _isSessionValid.close();
  }

  void restoreSession() async {
    try {
      user = User.fromJson(await sharedPref.read("user"));
      _isSessionValid.sink.add(true);
    } catch (Excepetion) {
      _isSessionValid.sink.add(false);
    }
  }

  void openSession(User user) async {
    sharedPref.save("user", user);
    this.user = user;
    _isSessionValid.sink.add(true);
  }

  void closeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
    _isSessionValid.sink.add(false);
  }
}

final authBloc = AuthorizationBloc();
