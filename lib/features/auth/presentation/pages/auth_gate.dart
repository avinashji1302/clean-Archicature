import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janu/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:janu/features/auth/presentation/bloc/auth_event.dart';
import 'package:janu/features/auth/presentation/bloc/auth_state.dart';
import 'package:janu/features/auth/presentation/pages/login_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  

  @override
  void initState(){
    super.initState();

    context.read<AuthBloc>().add(AuthEventStarted());
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(builder: (context,state){
      if(state is AuthLoading){
         return  Scaffold(body: Center(child: Text(''),));
      }

       if(state is AuthAuthenticated){
         return  Scaffold(body: Center(child: Text(''),));
      
      }

     if (state is AuthUnauthenticated) {
  return LoginPage();
}

      

       if(state is AuthError){
         return  Scaffold(body: Center(child: Text(state.message),));
      }
       return Scaffold(
          body: Center(child: Text("INITIAL")),
        );
    });
  }
}