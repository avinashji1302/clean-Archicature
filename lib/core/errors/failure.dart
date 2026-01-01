 import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  Failure(this.message);

   @override
  List<Object?> get props => [message];
    
}

class AuthFailure extends Failure{
  AuthFailure(super.message);

}

class NetworkFailure extends Failure{
  NetworkFailure(super.message);
   
}

