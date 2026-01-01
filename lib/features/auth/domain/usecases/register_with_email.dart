import 'package:dartz/dartz.dart';
import 'package:janu/core/errors/failure.dart';
import 'package:janu/features/auth/domain/entity/user_entity.dart';
import 'package:janu/features/auth/domain/repository/auth_repository.dart';

class RegisterWithEmail {
  final AuthRepository authRepository;

  RegisterWithEmail(this.authRepository);

  Future<Either<Failure,UserEntity>> call(String name, String email, String,password){
    return  authRepository.registerWithEmail(name, email, password);
  }
}