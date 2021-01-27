import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences_sample/bloc/authorization_bloc.dart';
import 'package:shared_preferences_sample/provider/repository.dart';

class LoginBloc {
  Repository repository = Repository();

  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      CombineLatestStream.combine2(email, password, (email, password) => true);

  Stream<bool> get loading => _loadingData.stream;

  void submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    _loadingData.sink.add(true);
    login(validEmail, validPassword);
  }

  login(String email, String password) async {
    String token = await repository.login(email, password);
    _loadingData.sink.add(false);
    authBloc.openSession(token);
  }

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _loadingData.close();
  }

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains("@")) {
        sink.add(email);
      } else {
        sink.addError("Enter a valid Email");
      }
    },
  );

  //The validation of the password. It must have more than three characters
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 3) {
        sink.add(password);
      } else {
        sink.addError("Enter a valid password");
      }
    },
  );
}
