import 'package:dartz/dartz.dart';
import 'package:janu/core/errors/failure.dart';
import 'package:janu/features/auth/domain/entity/user_entity.dart';
import 'package:janu/features/auth/domain/repository/auth_repository.dart';

class SigninWithGoogle {
 
  final AuthRepository authRepository;
   SigninWithGoogle(this.authRepository);

  Future<Either<Failure,UserEntity>> call(){
    return  authRepository.signInWithGoogle();
  }

}