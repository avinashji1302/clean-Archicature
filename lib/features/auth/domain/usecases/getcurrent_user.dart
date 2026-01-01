import 'package:dartz/dartz.dart';
import 'package:janu/core/errors/failure.dart';
import 'package:janu/features/auth/domain/entity/user_entity.dart';
import 'package:janu/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUser {
 
  final AuthRepository authRepository;
   GetCurrentUser(this.authRepository);

  Future<Either<Failure,UserEntity>> call(){
    return  authRepository.getCurrentUser();
  }

}