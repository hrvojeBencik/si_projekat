import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/authentication/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Home Page'),
          TextButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(SignOutEvent());
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    ));
  }
}
