import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:si_app/src/bloc/tillage/tillage_bloc.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:si_app/src/models/tillage.dart';
import 'package:si_app/src/services/authentication/user_repository.dart';

class NewTillageForm extends StatefulWidget {
  const NewTillageForm({Key? key, required this.closeForm, required this.plotId, required this.bloc}) : super(key: key);

  final Function() closeForm;
  final String plotId;
  final TillageBloc bloc;

  @override
  State<NewTillageForm> createState() => _NewTillageFormState();
}

class _NewTillageFormState extends State<NewTillageForm> {
  late final AppLocalizations _localization = AppLocalizations.of(context)!;
  DateTime? _selectedDate = DateTime.now();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  String _tillageType = '';

  @override
  void initState() {
    super.initState();
    _typeController.addListener(() {
      setState(() {
        _tillageType = _typeController.text;
      });
    });
  }

  @override
  void dispose() {
    _typeController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _typeField()),
        const SizedBox(width: 20),
        Expanded(
          child: _commentField(),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _dateField(),
        ),
        const SizedBox(width: 20),
        IconButton(
          onPressed: _tillageType == '' || _selectedDate == null
              ? null
              : () {
                  widget.closeForm();
                  final Tillage _tillage = Tillage(
                    plotId: widget.plotId,
                    userFirebaseId: context.read<UserRepository>().getFirebaseId(),
                    date: _selectedDate!,
                    quantity: '',
                    type: _tillageType,
                    comment: _commentController.text,
                  );
                  widget.bloc.add(AddTillageEvent(_tillage));
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
    );
  }

  Widget _typeField() {
    return TextField(
      controller: _typeController,
      cursorColor: FructifyColors.lightGreen,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: FructifyColors.whiteGreen),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: FructifyColors.lightGreen),
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: _localization.tillageTypeHint + '*',
        labelStyle: const TextStyle(
          color: FructifyColors.lightGreen,
        ),
      ),
    );
  }

  Widget _commentField() {
    return TextField(
      controller: _commentController,
      cursorColor: FructifyColors.lightGreen,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: FructifyColors.whiteGreen),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: FructifyColors.lightGreen),
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: _localization.comment,
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
