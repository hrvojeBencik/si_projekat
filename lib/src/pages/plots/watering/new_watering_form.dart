import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/watering/watering_bloc.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:si_app/src/models/watering.dart';
import 'package:si_app/src/services/authentication/user_repository.dart';

class NewWateringForm extends StatefulWidget {
  const NewWateringForm({Key? key, required this.closeForm, required this.plotId}) : super(key: key);

  final Function() closeForm;
  final String plotId;

  @override
  State<NewWateringForm> createState() => _NewWateringFormState();
}

class _NewWateringFormState extends State<NewWateringForm> {
  late final AppLocalizations _localization = AppLocalizations.of(context)!;
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  String _wateringType = '';

  @override
  void initState() {
    super.initState();
    _typeController.addListener(() {
      setState(() {
        _wateringType = _typeController.text;
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
        IconButton(
          onPressed: _wateringType == ''
              ? null
              : () {
                  widget.closeForm();
                  final Watering _watering = Watering(
                    plotId: widget.plotId,
                    userFirebaseId: context.read<UserRepository>().getFirebaseId(),
                    date: DateTime.now(),
                    quantity: '',
                    type: _wateringType,
                    comment: _commentController.text,
                  );
                  context.read<WateringBloc>().add(AddWateringEvent(_watering));
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
        labelText: _localization.wateringTypeHint + '*',
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
}
