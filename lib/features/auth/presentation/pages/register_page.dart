import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janu/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:janu/features/auth/presentation/bloc/auth_event.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController),
            TextField(controller: emailController),
            TextField(controller: passwordController),
            ElevatedButton(
              onPressed: () {
                // DISPATCH REGISTER EVENT
                context.read<AuthBloc>().add(
  AuthEventRegister(
    emailController.text.trim(),
    passwordController.text.trim(),
    nameController.text.trim(),
  ),
);

              },
              child: Text("Create Account"),
            ),
          ],
        ),
      ),
    );
  }
}
