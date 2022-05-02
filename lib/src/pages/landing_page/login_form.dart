import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/widgets/fructify_button.dart';

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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.loginHeader,
                      style: FructifyStyles.textStyle.headerStyle1,
                    ),
                  ),
                  const SizedBox(height: 90),
                  SizedBox(
                    width: 400,
                    child: TextField(
                      cursorColor: FructifyColors.lightGreen,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.email,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: FructifyColors.black),
                          borderRadius: BorderRadius.circular(200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: FructifyColors.black),
                          borderRadius: BorderRadius.circular(200),
                        ),
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 66,
                          height: 55,
                          decoration: const BoxDecoration(
                            color: FructifyColors.lightGreen,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(200),
                              bottomLeft: Radius.circular(200),
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: FructifyColors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    child: TextField(
                      cursorColor: FructifyColors.lightGreen,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.password,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: FructifyColors.black),
                          borderRadius: BorderRadius.circular(200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: FructifyColors.black),
                          borderRadius: BorderRadius.circular(200),
                        ),
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 66,
                          height: 55,
                          decoration: const BoxDecoration(
                            color: FructifyColors.lightGreen,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(200),
                              bottomLeft: Radius.circular(200),
                            ),
                          ),
                          child: const Icon(
                            Icons.lock,
                            color: FructifyColors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.errorMessage != null)
                    Text(
                      widget.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 20),
                  FructifyButton(
                    text: AppLocalizations.of(context)!.signIn,
                    onClick: () async {
                      context.read<AuthenticationBloc>().add(SignInEvent(
                          _emailController.text, _passwordController.text));
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.center,
                color: FructifyColors.darkGreen,
                width: 4,
                height: 300,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dontHaveAccount,
                    style: FructifyStyles.textStyle.headerStyle1.copyWith(
                      color: FructifyColors.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 180),
                  FructifyButton(
                    onClick: () {},
                    text: AppLocalizations.of(context)!.createAccountEasily,
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
