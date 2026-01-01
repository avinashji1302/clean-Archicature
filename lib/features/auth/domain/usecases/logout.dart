import 'package:dartz/dartz.dart';
import 'package:janu/core/errors/failure.dart';
import 'package:janu/features/auth/domain/repository/auth_repository.dart';

class Logout {
 
  final AuthRepository authRepository;
   Logout(this.authRepository);

  Future<Either<Failure,void>> call(){
    return  authRepository.logOut();
  }

}