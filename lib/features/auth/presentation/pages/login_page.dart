import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janu/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:janu/features/auth/presentation/bloc/auth_event.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController),
            TextField(controller: passwordController),
            ElevatedButton(
              onPressed: () {
                // DISPATCH EVENT HERE
                context.read<AuthBloc>().add(AuthEventLogin(
                      emailController.text,
                      passwordController.text,
                    ));
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
