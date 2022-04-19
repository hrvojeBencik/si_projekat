import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({Key? key, this.errorMessage}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.registerHeader,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                context.read<AuthenticationBloc>().add(
                      RegisterEvent(
                        _emailController.text,
                        _passwordController.text,
                      ),
                    );
              },
              child: Text(
                AppLocalizations.of(context)!.register,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
