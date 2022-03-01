import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/authentication/authentication_bloc.dart';
import 'package:si_app/src/pages/landing_page/login_form.dart';
import 'package:si_app/src/pages/landing_page/register_form.dart';

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
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: _authBloc,
        builder: (context, state) {
          if (state is UnauthenticatedState) {
            return _authForm(null);
          }

          if (state is AuthenticationErrorState) {
            return _authForm(state.errorMessage);
          }

          return Container();
        },
      ),
    );
  }

  Widget _authForm(String? errorMessage) {
    return Center(
      child: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isLoginSelected)
              Column(
                children: [
                  LoginForm(errorMessage: errorMessage),
                  TextButton(
                    onPressed: () {
                      _authBloc.add(SwitchAuthFormEvent());
                      setState(() {
                        _isLoginSelected = false;
                      });
                    },
                    child: const Text('Kreirajte nalog'),
                  ),
                ],
              )
            else
              Column(
                children: [
                  RegisterForm(errorMessage: errorMessage),
                  TextButton(
                    onPressed: () {
                      _authBloc.add(SwitchAuthFormEvent());
                      setState(() {
                        _isLoginSelected = true;
                      });
                    },
                    child: const Text('Ulogujte se'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
