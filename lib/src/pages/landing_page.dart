import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/authentication/authentication_bloc.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Landing Page',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Lozinka',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () async {
                      context.read<AuthenticationBloc>().add(RegisterEvent(
                          _emailController.text, _passwordController.text));
                    },
                    child: const Text('Registrujte se'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      context.read<AuthenticationBloc>().add(SignInEvent(
                          _emailController.text, _passwordController.text));
                    },
                    child: const Text('Ulogujte se'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
