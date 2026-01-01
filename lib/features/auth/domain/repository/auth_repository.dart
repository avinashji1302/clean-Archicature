import 'package:dartz/dartz.dart';
import 'package:janu/core/errors/failure.dart';
import 'package:janu/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure,UserEntity>> signInWithEmail(String email, String password);
  Future<Either<Failure,UserEntity>> registerWithEmail(String name,String email , String password);
  Future<Either<Failure,UserEntity>> signInWithGoogle();
  Future<Either<Failure,UserEntity>> getCurrentUser();
  Future<Either<Failure,void>> logOut();
}
