import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:si_app/src/bloc/care/care_bloc.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:si_app/src/models/care.dart';
import 'package:si_app/src/services/authentication/user_repository.dart';

class NewCareForm extends StatefulWidget {
  const NewCareForm({Key? key, required this.closeForm, required this.plotId, required this.bloc}) : super(key: key);

  final Function() closeForm;
  final String plotId;
  final CareBloc bloc;

  @override
  State<NewCareForm> createState() => _NewCareFormState();
}

class _NewCareFormState extends State<NewCareForm> {
  late final AppLocalizations _localization = AppLocalizations.of(context)!;
  DateTime? _selectedDate = DateTime.now();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String _careType = '';
  String _quantity = '';

  @override
  void initState() {
    super.initState();
    _typeController.addListener(() {
      setState(() {
        _careType = _typeController.text;
      });
    });
    _quantityController.addListener(() {
      setState(() {
        _quantity = _quantityController.text;
      });
    });
  }

  @override
  void dispose() {
    _typeController.dispose();
    _commentController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _inputField(_typeController, _localization.careTypeHint + '*')),
            const SizedBox(width: 20),
            Expanded(child: _inputField(_quantityController, _localization.careQuantityHint + '*')),
            const SizedBox(width: 20),
            Expanded(
              child: _dateField(),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: _careType == '' || _selectedDate == null || _quantity == ''
                  ? null
                  : () {
                      widget.closeForm();
                      final Care _care = Care(
                        plotId: widget.plotId,
                        userFirebaseId: context.read<UserRepository>().getFirebaseId(),
                        date: _selectedDate!,
                        quantity: _quantity,
                        type: _careType,
                        comment: _commentController.text,
                      );
                      widget.bloc.add(AddCareEvent(_care));
                    },
              icon: const Icon(
                Icons.check,
                color: FructifyColors.lightGreen,
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: widget.closeForm,
              icon: const Icon(
                Icons.close,
                color: FructifyColors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _inputField(_commentController, _localization.comment, capitalization: TextCapitalization.sentences),
      ],
    );
  }

  Widget _inputField(TextEditingController controller, String hint, {TextCapitalization capitalization = TextCapitalization.words}) {
    return TextField(
      controller: controller,
      cursorColor: FructifyColors.lightGreen,
      textCapitalization: capitalization,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: FructifyColors.whiteGreen),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: FructifyColors.lightGreen),
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: hint,
        labelStyle: const TextStyle(
          color: FructifyColors.lightGreen,
        ),
      ),
    );
  }

  Widget _dateField() {
    return TextButton(
      onPressed: () async {
        _selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        _selectedDate ??= DateTime.now();

        setState(() {});
      },
      child: Text(
        DateFormat('dd.MM.yyyy.').format(_selectedDate ?? DateTime.now()),
        style: const TextStyle(
          color: FructifyColors.lightGreen,
        ),
      ),
    );
  }
}
