part of 'app_field_base_builder.dart';

class AppDatePickerWidget extends AppFieldBaseBuilder {
  late final InputFieldBloc<DateTime?, dynamic>? _inputBloc;
  DateTime? _initTime;
  DateTime? _lastDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _open(context, _initTime);
      },
      child: DateTimeFieldBlocBuilder(
        dateTimeFieldBloc: _inputBloc!,
        isEnabled: false,
        format: DateFormat(DateTimeExt.ddMMyyy),
        initialDate: _initTime ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: _lastDate ?? DateTime(2100),
        textColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) =>
              Theme.of(context).colorScheme.onBackground,
        ),
        showClearIcon: false,
        decoration: _inputDecoration ??
            InputDecoration(
              labelText: _isRequired == true ? '$_labelText (*)' : _labelText,
              prefixIcon: _prefixIcon,
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              contentPadding: EdgeInsets.all(
                AppSizeExt.of.majorPaddingScale(4),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    AppSizeExt.of.majorScale(4),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  Future<void> _open(BuildContext context, DateTime? initialDate) async {
    DateTime date = initialDate ?? DateTime.now();
    DateTime? selectDate;

    await showModalBottomSheet<DateTime>(
      context: context,
      builder: (BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        color: AppColorPalette.of.grayColor[1],
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButtonTextWidget()
                    .setButtonText(R.strings.cancel)
                    .setOnPressed(
                  () {
                    Navigator.of(context).pop();
                  },
                ).build(context),
                AppButtonTextWidget()
                    .setButtonText(R.strings.done)
                    .setOnPressed(
                  () {
                    if (selectDate != null) {
                      _inputBloc!.changeValue(selectDate);
                    }
                    Navigator.of(context).pop();
                  },
                ).build(context),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: date,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime newDate) {
                  selectDate = newDate;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppDatePickerWidget setInputBloc(
      InputFieldBloc<DateTime?, dynamic> inputBloc) {
    _inputBloc = inputBloc;
    return this;
  }

  AppDatePickerWidget setInitTime(DateTime initTime) {
    _initTime = initTime;
    return this;
  }

  AppDatePickerWidget setLastDate(DateTime? lastDate) {
    _lastDate = lastDate;
    return this;
  }

  @override
  AppDatePickerWidget setAutoCorrect(bool? autoCorrect) {
    _autocorrect = autoCorrect;
    return this;
  }

  @override
  AppDatePickerWidget setAutoFillHints(Iterable<String>? autofillHints) {
    _autofillHints = autofillHints;
    return this;
  }

  @override
  AppDatePickerWidget setAutoFocus(bool? autofocus) {
    _autofocus = autofocus;
    return this;
  }

  @override
  AppDatePickerWidget setBloc(TextFieldBloc? bloc) {
    throw UnimplementedError();
  }

  @override
  AppDatePickerWidget setEnableOnlyWhenFormBlocCanSubmit(
      bool? enableOnlyWhenFormBlocCanSubmit) {
    _enableOnlyWhenFormBlocCanSubmit = enableOnlyWhenFormBlocCanSubmit;
    return this;
  }

  @override
  AppDatePickerWidget setErrorBuilder(
      String? Function(BuildContext p1, Object p2)? errorBuilder) {
    _errorBuilder = errorBuilder;
    return this;
  }

  @override
  AppDatePickerWidget setExpands(bool? expands) {
    _expands = expands;
    return this;
  }

  @override
  AppDatePickerWidget setFocusNode(FocusNode? focusNode) {
    _focusNode = focusNode;
    return this;
  }

  @override
  AppDatePickerWidget setIsEnabled(bool? isEnabled) {
    _isEnabled = isEnabled;
    return this;
  }

  @override
  AppDatePickerWidget setIsReadOnly(bool? isReadOnly) {
    _isReadOnly = isReadOnly;
    return this;
  }

  @override
  AppDatePickerWidget setKeyboardType(TextInputType? keyboardType) {
    _keyboardType = keyboardType;
    return this;
  }

  @override
  AppDatePickerWidget setMaxLength(int? maxLength) {
    _maxLength = maxLength;
    return this;
  }

  @override
  AppDatePickerWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppDatePickerWidget setMinLines(int? minLines) {
    _minLines = minLines;
    return this;
  }

  @override
  AppDatePickerWidget setObscureText(bool? obscureText) {
    _obscureText = obscureText;
    return this;
  }

  @override
  AppDatePickerWidget setOnChanged(void Function(String p1)? onChanged) {
    _onChanged = onChanged;
    return this;
  }

  @override
  AppDatePickerWidget setOnEditingComplete(void Function()? onEditingComplete) {
    _onEditingComplete = onEditingComplete;
    return this;
  }

  @override
  AppDatePickerWidget setOnSubmitted(void Function(String p1)? onSubmitted) {
    _onSubmitted = onSubmitted;
    return this;
  }

  @override
  AppDatePickerWidget setPadding(EdgeInsetsGeometry? padding) {
    _padding = padding;
    return this;
  }

  @override
  AppDatePickerWidget setSuffixButton(SuffixButton? suffixButton) {
    _suffixButton = suffixButton;
    return this;
  }

  @override
  AppDatePickerWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppDatePickerWidget setTextAlignVertical(
      TextAlignVertical? textAlignVertical) {
    _textAlignVertical = textAlignVertical;
    return this;
  }

  @override
  AppDatePickerWidget setTextCapitalization(
      TextCapitalization? textCapitalization) {
    _textCapitalization = textCapitalization;
    return this;
  }

  @override
  AppDatePickerWidget setTextDirection(TextDirection? textDirection) {
    _textDirection = textDirection;
    return this;
  }

  @override
  AppDatePickerWidget setTextInputAction(TextInputAction? textInputAction) {
    _textInputAction = textInputAction;
    return this;
  }

  @override
  AppDatePickerWidget setDecoration(InputDecoration? inputDecoration) {
    _inputDecoration = inputDecoration;
    return this;
  }

  @override
  AppDatePickerWidget setLabelText(String? labelText) {
    _labelText = labelText;
    return this;
  }

  @override
  AppDatePickerWidget setPrefixIcon(Widget? prefixIcon) {
    _prefixIcon = prefixIcon;
    return this;
  }

  @override
  AppDatePickerWidget setIsRequired(bool? isRequired) {
    _isRequired = isRequired;
    return this;
  }
}
