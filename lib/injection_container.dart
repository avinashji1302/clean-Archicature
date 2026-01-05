import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:janu/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:janu/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:janu/features/auth/data/repository/auth_repostory_imp.dart';
import 'package:janu/features/auth/domain/repository/auth_repository.dart';
import 'package:janu/features/auth/domain/usecases/getcurrent_user.dart';
import 'package:janu/features/auth/domain/usecases/logout.dart';
import 'package:janu/features/auth/domain/usecases/register_with_email.dart';
import 'package:janu/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:janu/features/auth/domain/usecases/signin_with_google.dart';

final sl = GetIt.instance;

Future<void> init() async {


   //! -------------------------------
  //! BLOCS (UI LAYER)
  //! -------------------------------

  sl.registerFactory(()=>AuthBloc(signInWithEmail: sl(), getCurrentUser: sl(), registerWithEmail: sl(), signinWithGoogle: sl(), logout: sl()));


  //! -------------------------------
  //! USE CASES (DOMAIN LAYER)
  //! -------------------------------
  sl.registerLazySingleton(() => SignInWithEmail(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => RegisterWithEmail(sl()));
  sl.registerLazySingleton(() => SigninWithGoogle(sl()));
  sl.registerLazySingleton(() => Logout(sl()));


  // 🔹 External
  sl.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );

  sl.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn.instance,
  );

   //! -------------------------------
  //! REPOSITORY
  //! -------------------------------
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepostoryImp(
      authRemoteDatasource: sl(),
    ),
  );

  //! -------------------------------
  //! DATA SOURCES
  //! -------------------------------
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImp(
      sl<FirebaseAuth>(),
      sl<GoogleSignIn>(),
    ),
  );

  //! EXTERNAL (Firebase / SDKs)
  //! -------------------------------
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn.instance);
}