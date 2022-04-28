import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:si_app/src/constants/colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key, this.errorMessage}) : super(key: key);

  final String? errorMessage;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 1200,
        margin: const EdgeInsets.symmetric(
          horizontal: 130,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 60,
        ),
        decoration: BoxDecoration(
          color: FructifyColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: const Offset(15, 15),
              blurRadius: 4,
              color: FructifyColors.black.withOpacity(0.25),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.loginHeader,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 90),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.email,
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.password,
                    ),
                  ),
                  if (widget.errorMessage != null)
                    Text(
                      widget.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      context.read<AuthenticationBloc>().add(SignInEvent(
                          _emailController.text, _passwordController.text));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signIn,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nemaš nalog?',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: FructifyColors.darkGreen,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Registruj se lako'),
                  ),
                  Image.asset(
                    'assets/images/create-account.png',
                    height: 280,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
