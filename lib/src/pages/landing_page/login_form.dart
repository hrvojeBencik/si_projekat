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
    return LayoutBuilder(builder: (contex, constraints) {
      if (constraints.maxWidth <= 1000) return _mobileLayout(context, constraints.maxWidth);
      return _desktopLayout(context, constraints.maxWidth);
    });
  }

  Widget _desktopLayout(BuildContext context, double screenWidth) {
    return Center(
      child: Container(
        width: screenWidth * 0.8,
        margin: const EdgeInsets.only(
          top: 100,
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
            Expanded(child: _leftColumn(context, screenWidth: screenWidth)),
            _customDivider(),
            Expanded(child: _rightColumn(context, screenWidth: screenWidth)),
          ],
        ),
      ),
    );
  }

  Widget _mobileLayout(BuildContext context, double screenWidth) {
    return Center(
      child: Container(
        width: screenWidth,
        margin: const EdgeInsets.only(
          top: 100,
          left: 10,
          right: 10,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _leftColumn(context, isMobile: true, screenWidth: screenWidth),
            const SizedBox(height: 30),
            _customDivider(isMobile: true),
            const SizedBox(height: 30),
            _rightColumn(context, isMobile: true, screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }

  Align _customDivider({bool isMobile = false}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.center,
        color: FructifyColors.darkGreen,
        width: isMobile ? 300 : 4,
        height: isMobile ? 4 : 300,
      ),
    );
  }

  Widget _rightColumn(BuildContext context, {bool isMobile = false, required double screenWidth}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.dontHaveAccount,
          style: FructifyStyles.textStyle.headerStyle1.copyWith(
            color: FructifyColors.darkGreen,
          ),
        ),
        const SizedBox(height: 30),
        FructifyButton(
          onClick: () {},
          text: AppLocalizations.of(context)!.createAccountEasily,
        ),
        Image.asset(
          'assets/images/create-account.png',
          height: 280,
        ),
      ],
    );
  }

  Widget _leftColumn(BuildContext context, {bool isMobile = false, required double screenWidth}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: isMobile ? Alignment.topCenter : Alignment.centerLeft,
          child: Text(
            isMobile ? AppLocalizations.of(context)!.loginHeader.replaceAll('\n', ' ') : AppLocalizations.of(context)!.loginHeader,
            style: FructifyStyles.textStyle.headerStyle1,
          ),
        ),
        const SizedBox(height: 90),
        Container(
          width: isMobile ? 600 : 400,
          margin: const EdgeInsets.only(
            right: 30,
          ),
          child: TextField(
            cursorColor: FructifyColors.lightGreen,
            controller: _emailController,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.email,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: FructifyColors.black),
                borderRadius: BorderRadius.circular(200),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: FructifyColors.black),
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
        Container(
          width: isMobile ? 600 : 400,
          margin: const EdgeInsets.only(
            right: 30,
          ),
          child: TextField(
            cursorColor: FructifyColors.lightGreen,
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.password,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: FructifyColors.black),
                borderRadius: BorderRadius.circular(200),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: FructifyColors.black),
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
            context.read<AuthenticationBloc>().add(SignInEvent(_emailController.text, _passwordController.text));
          },
        ),
      ],
    );
  }
}
