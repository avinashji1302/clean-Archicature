import 'package:dartz/dartz.dart';
import 'package:janu/core/errors/failure.dart';
import 'package:janu/features/auth/domain/entity/user_entity.dart';
import 'package:janu/features/auth/domain/repository/auth_repository.dart';

class SignInWithEmail {
 final AuthRepository authRepository;

 const SignInWithEmail(this.authRepository);

  Future<Either<Failure,UserEntity>> call(String email ,String password) async{
    return authRepository.signInWithEmail(email, password);
  }
  

}