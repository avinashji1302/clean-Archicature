import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janu/features/auth/presentation/bloc/auth_event.dart';
import 'package:janu/features/auth/presentation/bloc/auth_state.dart';
import 'package:janu/features/auth/domain/usecases/getcurrent_user.dart';
import 'package:janu/features/auth/domain/usecases/logout.dart';
import 'package:janu/features/auth/domain/usecases/register_with_email.dart';
import 'package:janu/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:janu/features/auth/domain/usecases/signin_with_google.dart';

 class AuthBloc  extends Bloc<AuthEvent , AuthState>{
   final SignInWithEmail signInWithEmail;
   final GetCurrentUser getCurrentUser;
   final RegisterWithEmail registerWithEmail;
   final SigninWithGoogle signinWithGoogle;
   final Logout logout;
   
  AuthBloc({required this.signInWithEmail,  required this.getCurrentUser, required this.registerWithEmail, required this.signinWithGoogle, required this.logout}):super(AuthInitial()){
     on<AuthEventRegister>(_onAuthEventRegister);
     on<AuthEventStarted>(_onEventStarted);
     on<AuthEventLogin>(_onAuthEventLogin);
    on<AuthEventGoogleLogin>(_onEventGoogleLogin);
     on<AuthEventLogout>(_onEventLogout);
      

     
  }

  Future<void> _onAuthEventLogin(AuthEventLogin event, Emitter<AuthState> emit)  async{

    emit(AuthLoading());

    // user login process

  final response = await signInWithEmail(event.email, event.password);

      response.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthAuthenticated(user)),
      );
  }


// user session check handler
  Future<void> _onEventStarted(AuthEventStarted event, Emitter<AuthState> emit)  async{

   emit(AuthLoading());
    final currentUser = await getCurrentUser();

    currentUser.fold((failure)=>emit(AuthUnauthenticated('Loged out ,  Please login again!')), (user)=>emit(AuthAuthenticated(user)));
  }


// user registration handler
  Future<void> _onAuthEventRegister(AuthEventRegister event, Emitter<AuthState> emit) async {

    emit(AuthLoading());

    final currentUser = await registerWithEmail(event.name,event.email,event.password);


     currentUser.fold((failure)=>emit(AuthError(failure.message)), (user)=>emit(AuthAuthenticated(user)));
  }

// user google sign in handler
  Future<void> _onEventGoogleLogin(AuthEventGoogleLogin event, Emitter<AuthState> emit) async {

    emit(AuthLoading());

    // user google sign in process
    final currentUser = await signinWithGoogle();
    currentUser.fold((failure)=>emit(AuthError(failure.message)), (user)=>emit(AuthAuthenticated(user))); 

  }

// user logout handler
  Future<void> _onEventLogout(AuthEventLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    // user logout process
      final user = await logout();
      user.fold((failure) => emit(AuthError(failure.message)), (_) => emit(AuthUnauthenticated("Logged out successfully")));
  }
}