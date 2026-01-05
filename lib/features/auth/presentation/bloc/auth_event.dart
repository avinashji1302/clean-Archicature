import 'package:equatable/equatable.dart';

 abstract class AuthEvent extends Equatable{

 const  AuthEvent();
  @override
  List<Object?> get props => [];
}


class AuthEventStarted extends AuthEvent{

}

class AuthEventLogin extends AuthEvent{

final String email;
final String password;

 const AuthEventLogin(this.email, this.password);

  @override
  List<Object?> get props => [email, password];


}

class AuthEventLogout extends AuthEvent{

}

class AuthEventGoogleLogin extends AuthEvent{

}


class AuthEventRegister extends AuthEvent{
  
final String email;
final String password;
final String name;


 const AuthEventRegister(   this.email, this.password , this.name);

  @override
  List<Object?> get props => [email, password , name];

}