import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/models/user.dart';
import 'package:si_app/src/services/api_service.dart';
import 'package:si_app/src/widgets/fructify_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key, this.errorMessage, required this.switchForm}) : super(key: key);

  final String? errorMessage;
  final Function({bool selectLogin}) switchForm;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isTermsChecked = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
          vertical: 30,
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
          children: [
            Text(
              AppLocalizations.of(context)!.createAccount,
              style: FructifyStyles.textStyle.headerStyle1,
            ),
            _showErrorMessage(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _inputField(
                        _firstNameController,
                        AppLocalizations.of(context)!.firstName,
                      ),
                      _inputField(
                        _lastNameController,
                        AppLocalizations.of(context)!.lastName,
                      ),
                      _inputField(
                        _emailController,
                        AppLocalizations.of(context)!.email,
                      ),
                      _inputField(
                        _passwordController,
                        AppLocalizations.of(context)!.password,
                        isPassword: true,
                      ),
                      _inputField(
                        _confirmPasswordController,
                        AppLocalizations.of(context)!.confirmPassword,
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.alreadyHaveAccount,
                        style: FructifyStyles.textStyle.headerStyle1.copyWith(
                          color: FructifyColors.darkGreen,
                        ),
                      ),
                      const SizedBox(height: 30),
                      FructifyButton(
                        onClick: () {
                          widget.switchForm(selectLogin: true);
                        },
                        text: AppLocalizations.of(context)!.signIn,
                      ),
                      Image.asset(
                        'assets/images/register.png',
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: _isTermsChecked,
                  onChanged: (value) => setState(
                    () => _isTermsChecked = value!,
                  ),
                  fillColor: MaterialStateProperty.all<Color>(
                    FructifyColors.lightGreen,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.acceptTerms,
                ),
              ],
            ),
            const SizedBox(height: 20),
            FructifyButton(
              text: AppLocalizations.of(context)!.register,
              onClick: !_formValidator()
                  ? null
                  : () {
                      context.read<AuthenticationBloc>().add(
                            RegisterEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              image: '',
                            ),
                          );
                    },
            )
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
          vertical: 30,
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
          children: [
            Text(
              AppLocalizations.of(context)!.createAccount,
              style: FructifyStyles.textStyle.headerStyle1,
              textAlign: TextAlign.center,
            ),
            _showErrorMessage(),
            const SizedBox(height: 20),
            Column(
              children: [
                Column(
                  children: [
                    _inputField(
                      _firstNameController,
                      AppLocalizations.of(context)!.firstName,
                    ),
                    _inputField(
                      _lastNameController,
                      AppLocalizations.of(context)!.lastName,
                    ),
                    _inputField(
                      _emailController,
                      AppLocalizations.of(context)!.email,
                    ),
                    _inputField(
                      _passwordController,
                      AppLocalizations.of(context)!.password,
                      isPassword: true,
                    ),
                    _inputField(
                      _confirmPasswordController,
                      AppLocalizations.of(context)!.confirmPassword,
                      isPassword: true,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/register.png',
                  height: 200,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: _isTermsChecked,
                  onChanged: (value) => setState(
                    () => _isTermsChecked = value!,
                  ),
                  fillColor: MaterialStateProperty.all<Color>(
                    FructifyColors.lightGreen,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.acceptTerms,
                ),
              ],
            ),
            const SizedBox(height: 20),
            FructifyButton(
              text: AppLocalizations.of(context)!.register,
              onClick: !_formValidator()
                  ? null
                  : () {
                      context.read<AuthenticationBloc>().add(
                            RegisterEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              image: '',
                            ),
                          );
                    },
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context)!.alreadyHaveAccount,
              style: FructifyStyles.textStyle.headerStyle1.copyWith(
                color: FructifyColors.darkGreen,
              ),
            ),
            const SizedBox(height: 30),
            FructifyButton(
              onClick: () {
                widget.switchForm(selectLogin: true);
              },
              text: AppLocalizations.of(context)!.signIn,
            ),
          ],
        ),
      ),
    );
  }

  bool _formValidator() {
    if (!_isTermsChecked) return false;
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
      return false;
    }

    return true;
  }

  Widget _showErrorMessage() {
    if (widget.errorMessage != null) {
      return Text(
        widget.errorMessage!,
        style: const TextStyle(color: Colors.red),
      );
    }

    return Container();
  }

  Widget _inputField(TextEditingController controller, String hintText, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 42, right: 42),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        cursorColor: FructifyColors.lightGreen,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isCollapsed: true,
          hintText: hintText,
          contentPadding: const EdgeInsets.only(left: 30, top: 24, bottom: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: FructifyColors.black),
            borderRadius: BorderRadius.circular(200),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: FructifyColors.black),
            borderRadius: BorderRadius.circular(200),
          ),
        ),
      ),
    );
  }
}
