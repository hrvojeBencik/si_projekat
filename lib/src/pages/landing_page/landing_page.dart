import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/authentication/authentication_bloc.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/pages/landing_page/login_form.dart';
import 'package:si_app/src/pages/landing_page/register_form.dart';
import 'package:si_app/src/pages/landing_page/verify_email.dart';
import 'package:si_app/src/widgets/fructify_footer.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late AuthenticationBloc _authBloc;
  bool _isLoginSelected = true;

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthenticationBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FructifyColors.white,
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: _authBloc,
        builder: (context, state) {
          if (state is UnauthenticatedState) {
            return _authForm(null);
            // return _verifyEmail();
          }

          if (state is AuthenticationErrorState) {
            return _authForm(state.errorMessage);
            // return _verifyEmail();
          }

          if (state is NotVerifiedEmailState) {
            return _verifyEmail();
          }

          return Container();
        },
      ),
    );
  }

  void switchForm({bool selectLogin = true}) {
    _authBloc.add(SwitchAuthFormEvent());
    setState(() {
      _isLoginSelected = selectLogin;
    });
  }

  Widget _authForm(String? errorMessage) {
    return Stack(
      children: [
        _authScreenBackground(),
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isLoginSelected) LoginForm(errorMessage: errorMessage, switchForm: switchForm) else RegisterForm(errorMessage: errorMessage, switchForm: switchForm),
              ],
            ),
          ),
        ),
      ],
    );
    //
  }

  Widget _verifyEmail() {
    return Stack(
      children: [
        _authScreenBackground(),
        const Center(
          child: VerifyEmail(),
        ),
      ],
    );
    //
  }

  Widget _authScreenBackground() {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            width: double.infinity,
            color: FructifyColors.whiteGreen,
            child: Image.asset(
              'assets/images/fructify-logo.png',
              width: 150,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            color: FructifyColors.darkGreen,
          ),
        ),
        Expanded(
          flex: 1,
          child: FructifyFooter(context: context),
        ),
      ],
    );
  }
}
