import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:si_app/src/bloc/yield/yield_bloc.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:si_app/src/models/yield.dart';
import 'package:si_app/src/services/authentication/user_repository.dart';

class NewYieldForm extends StatefulWidget {
  const NewYieldForm({Key? key, required this.closeForm, required this.plotId, required this.bloc}) : super(key: key);

  final Function() closeForm;
  final String plotId;
  final YieldBloc bloc;

  @override
  State<NewYieldForm> createState() => _NewYieldFormState();
}

class _NewYieldFormState extends State<NewYieldForm> {
  late final AppLocalizations _localization = AppLocalizations.of(context)!;
  DateTime? _selectedDate = DateTime.now();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _yieldController = TextEditingController();
  YieldType _yieldType = YieldType.expense;
  String _amount = '';
  String _yieldAmount = '';

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      setState(() {
        _amount = _amountController.text;
      });
    });

    _yieldController.addListener(() {
      setState(() {
        _yieldAmount = _yieldController.text;
      });
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _amountController.dispose();
    _yieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _yieldTypeDropdown()),
            const SizedBox(width: 20),
            Expanded(child: _inputField(_amountController, _localization.amountHint + '*')),
            const SizedBox(width: 20),
            if (_yieldType == YieldType.expense)
              Expanded(
                child: _dateField(),
              )
            else
              Expanded(child: _inputField(_yieldController, _localization.yieldHint + '*')),
            const SizedBox(width: 20),
            IconButton(
              onPressed: _amount == '' || _selectedDate == null || (_yieldType == YieldType.income && _yieldAmount == '')
                  ? null
                  : () {
                      widget.closeForm();
                      final Yield _yield = Yield(
                        plotId: widget.plotId,
                        userFirebaseId: context.read<UserRepository>().getFirebaseId(),
                        date: _selectedDate!,
                        amount: _yieldType == YieldType.income ? _yieldAmount : '',
                        income: _yieldType == YieldType.income ? _amount : '',
                        expense: _yieldType == YieldType.expense ? _amount : '',
                        comment: _commentController.text,
                      );
                      widget.bloc.add(AddYieldEvent(_yield));
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
        Row(
          children: [
            if (_yieldType == YieldType.income)
              Expanded(
                child: _dateField(),
              ),
            Expanded(child: _inputField(_commentController, _yieldType == YieldType.expense ? _localization.expenseCommentHint : _localization.comment, capitalization: TextCapitalization.sentences)),
          ],
        ),
      ],
    );
  }

  Widget _yieldTypeDropdown() {
    return DropdownButton<YieldType>(
      value: _yieldType,
      items: [
        DropdownMenuItem(
          child: Text(
            _localization.expense + '*',
            style: const TextStyle(
              color: FructifyColors.lightGreen,
            ),
          ),
          value: YieldType.expense,
        ),
        DropdownMenuItem(
          child: Text(
            _localization.income + '*',
            style: const TextStyle(
              color: FructifyColors.lightGreen,
            ),
          ),
          value: YieldType.income,
        ),
      ],
      onChanged: (value) {
        setState(() {
          _yieldType = value!;
        });
      },
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
