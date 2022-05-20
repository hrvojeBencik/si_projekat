import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:si_app/src/bloc/authentication/authentication_bloc.dart';
import 'package:si_app/src/bloc/plots/bloc/plots_bloc.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/models/user.dart';
import 'package:si_app/src/services/api_service.dart';
import 'package:si_app/src/services/authentication/user_repository.dart';
import 'package:si_app/src/utils/toast.dart';
import 'package:si_app/src/widgets/custom_divider.dart';
import 'package:si_app/src/widgets/fructify_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:si_app/src/widgets/fructify_loader.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late UserRepository userRepository;
  late Future<User?> _getCurrentUser;
  late Size size;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? _selectedImage;

  @override
  void initState() {
    super.initState();
    userRepository = context.read<UserRepository>();
    _getCurrentUser = userRepository.getCurrentUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is PasswordResetMailSentState) {
            displayToast(
              message: AppLocalizations.of(context)!.resetPasswordMailSent,
              duration: const Duration(seconds: 5),
            );
          }
        },
        child: Center(
          child: SizedBox(
            width: size.width > 1000 ? size.width * 0.4 : size.width * 0.95,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder<User?>(
                  future: _getCurrentUser,
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const FructifyLoader();
                    }

                    _firstNameController.text = snapshot.data!.firstName;
                    _lastNameController.text = snapshot.data!.lastName;
                    _selectedImage = snapshot.data!.image;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () async {
                              final ImagePicker _picker = ImagePicker();
                              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                Uint8List bytes = await image.readAsBytes();
                                setState(() {
                                  _selectedImage = base64Encode(bytes);
                                  snapshot.data!.setImage = _selectedImage!;
                                });
                              }
                            },
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: FructifyColors.whiteGreen,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: _selectedImage == null
                                  ? const Icon(
                                      Icons.add_a_photo_outlined,
                                      color: FructifyColors.lightGreen,
                                      size: 42,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.memory(
                                        base64Decode(_selectedImage!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.email_outlined,
                              color: FructifyColors.lightGreen,
                              size: 30,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                snapshot.data!.email,
                                style: TextStyle(
                                  fontSize: size.width > 1000 ? 24 : 16,
                                ),
                              ),
                            ),
                            TextButton(
                              child: Text(
                                AppLocalizations.of(context)!.resetPassword,
                                style: const TextStyle(
                                  color: FructifyColors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                context.read<AuthenticationBloc>().add(ResetPasswordEvent());
                              },
                            ),
                          ],
                        ),
                        _inputField(_firstNameController, 'Ime'),
                        _inputField(_lastNameController, 'Prezime'),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: FructifyButton(
                            text: AppLocalizations.of(context)!.saveChanges,
                            onClick: () {
                              final userData = {
                                'firstName': _firstNameController.text,
                                'lastName': _lastNameController.text,
                                'image': _selectedImage,
                              };
                              context.read<ApiService>().updateUser(userData, snapshot.data!.firebaseId);
                              displayToast(message: AppLocalizations.of(context)!.profileChangesSaved);
                            },
                          ),
                        )
                      ],
                    );
                  }),
                ),
                const CustomDivider(),
                FructifyButton(
                  onClick: () {
                    context.read<PlotsBloc>().clearPlotList();
                    context.read<AuthenticationBloc>().add(SignOutEvent());
                  },
                  text: AppLocalizations.of(context)!.logout,
                  bgColor: FructifyColors.red,
                  hoverColor: Colors.red[300],
                  detailsColor: FructifyColors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
      ),
      child: TextField(
        controller: controller,
        cursorColor: FructifyColors.lightGreen,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: const EdgeInsets.only(left: 30, top: 24, bottom: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: FructifyColors.black.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: FructifyColors.lightGreen),
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: label,
          labelStyle: const TextStyle(color: FructifyColors.lightGreen),
        ),
      ),
    );
  }
}
