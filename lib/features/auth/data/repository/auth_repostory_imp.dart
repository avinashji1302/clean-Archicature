import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:janu/core/errors/failure.dart';
import 'package:janu/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:janu/features/auth/data/model/user_model.dart';
import 'package:janu/features/auth/domain/entity/user_entity.dart';
import 'package:janu/features/auth/domain/repository/auth_repository.dart';

class AuthRepostoryImp  implements  AuthRepository{


    final AuthRemoteDatasource authRemoteDatasource;
    AuthRepostoryImp(this.authRemoteDatasource);

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
   try {
     UserModel? response = await  authRemoteDatasource.getCurrentUser();

     if(response!=null){
     final userEntity = UserEntity(id: response.id, email: response.email, name: response.name, photoUrl: response.photoUrl);

    return Right(userEntity);

     }

     return Left(
      AuthFailure("Cant find the user")
     );


   } on FirebaseAuthException catch (e) {
      return  Left(AuthFailure(e.message ?? 'cant find current user'));
    }
 
  }

  @override
  Future<Either<Failure, void>> logOut() async {
   try {
    await  authRemoteDatasource.logOut(); 

   return Right(null);
   } on FirebaseAuthException catch (e) {
     return  Left(AuthFailure(e.message ?? 'Sign in failed'));
   }
  }

  @override
  Future<Either<Failure, UserEntity>> registerWithEmail(String name, String email, String password) async {
   
    try {
      UserModel response = await  authRemoteDatasource.registerInWithEmail(name, email, password) ;

     final userEntity = UserEntity(email: response.email, name: response.name,id: response.id,photoUrl: response.photoUrl);
      return Right(userEntity);
    } on FirebaseAuthException catch(e) {
         return  Left(AuthFailure(e.message ?? 'Sign up failed'));
    }
      
    
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail(String email, String password) async {
    try {
      UserModel response = await  authRemoteDatasource.signInWithEmail(email, password);

        final userEntity = UserEntity(email: response.email, name: response.name,id: response.id,photoUrl: response.photoUrl);
      return Right(userEntity);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Sign in failed'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
   try {
     final response = await authRemoteDatasource.signInWithGoogle();

     final userEntity = UserEntity(id: response.id, email: response.email, name: response.name, photoUrl: response.photoUrl);

     return Right(userEntity);
   } on FirebaseAuthException catch (e) {
     return Left(AuthFailure(e.message ?? "Sign in with google failed"));
   }
}}