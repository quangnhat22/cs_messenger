part of 'app_field_base_builder.dart';

class AppDropDownWidget<T> extends AppFieldBaseBuilder {
  late final SelectFieldBloc<T, dynamic> _selectBloc;
  late final List<T>? _items;
  late final String? _titleDialog;
  late final Widget Function(BuildContext, T, bool)? _itemBuilder;
  late final double? _maxHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _open(context);
      },
      child: DropdownFieldBlocBuilder<T>(
        selectFieldBloc: _selectBloc,
        isEnabled: false,
        decoration: InputDecoration(
          labelText: _isRequired == true ? '$_labelText (*)' : _labelText,
          prefixIcon: const Icon(Icons.sentiment_satisfied),
          contentPadding: EdgeInsets.all(
            AppSizeExt.of.majorPaddingScale(4),
          ),
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppSizeExt.of.majorScale(4),
              ),
            ),
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
        itemBuilder: (context, value) => const FieldItem(child: Text('-')),
      ),
    );
  }

  Future<void> _open(BuildContext context) async {
    await SelectDialog.showModal<T>(
      context,
      label: _titleDialog,
      titleStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
      showSearchBox: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      selectedValue: _selectBloc.value,
      items: _items,
      constraints:
          _maxHeight != null ? BoxConstraints(maxHeight: _maxHeight!) : null,
      itemBuilder: _itemBuilder,
      onChange: _selectBloc.updateValue,
    );
  }

  AppDropDownWidget setSelectBloc(SelectFieldBloc<T, dynamic> selectBloc) {
    _selectBloc = selectBloc;
    return this;
  }

  AppDropDownWidget setItems(List<T> items) {
    _items = items;
    return this;
  }

  AppDropDownWidget setTitleDialog(String titleDialog) {
    _titleDialog = titleDialog;
    return this;
  }

  AppDropDownWidget setItemBuilder(
      Widget Function(BuildContext, T, bool)? itemBuilder) {
    _itemBuilder = itemBuilder;
    return this;
  }

  AppDropDownWidget setMaxHeight(double maxHeight) {
    _maxHeight = maxHeight;
    return this;
  }

  @override
  AppDropDownWidget setAutoCorrect(bool? autoCorrect) {
    _autocorrect = autoCorrect;
    return this;
  }

  @override
  AppDropDownWidget setAutoFillHints(Iterable<String>? autofillHints) {
    _autofillHints = autofillHints;
    return this;
  }

  @override
  AppDropDownWidget setAutoFocus(bool? autofocus) {
    _autofocus = autofocus;
    return this;
  }

  @override
  AppDropDownWidget setBloc(TextFieldBloc? bloc) {
    throw UnimplementedError();
  }

  @override
  AppDropDownWidget setEnableOnlyWhenFormBlocCanSubmit(
      bool? enableOnlyWhenFormBlocCanSubmit) {
    _enableOnlyWhenFormBlocCanSubmit = enableOnlyWhenFormBlocCanSubmit;
    return this;
  }

  @override
  AppDropDownWidget setErrorBuilder(
      String? Function(BuildContext p1, Object p2)? errorBuilder) {
    _errorBuilder = errorBuilder;
    return this;
  }

  @override
  AppDropDownWidget setExpands(bool? expands) {
    _expands = expands;
    return this;
  }

  @override
  AppDropDownWidget setFocusNode(FocusNode? focusNode) {
    _focusNode = focusNode;
    return this;
  }

  @override
  AppDropDownWidget setIsEnabled(bool? isEnabled) {
    _isEnabled = isEnabled;
    return this;
  }

  @override
  AppDropDownWidget setIsReadOnly(bool? isReadOnly) {
    _isReadOnly = isReadOnly;
    return this;
  }

  @override
  AppDropDownWidget setKeyboardType(TextInputType? keyboardType) {
    _keyboardType = keyboardType;
    return this;
  }

  @override
  AppDropDownWidget setMaxLength(int? maxLength) {
    _maxLength = maxLength;
    return this;
  }

  @override
  AppDropDownWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppDropDownWidget setMinLines(int? minLines) {
    _minLines = minLines;
    return this;
  }

  @override
  AppDropDownWidget setObscureText(bool? obscureText) {
    _obscureText = obscureText;
    return this;
  }

  @override
  AppDropDownWidget setOnChanged(void Function(String p1)? onChanged) {
    _onChanged = onChanged;
    return this;
  }

  @override
  AppDropDownWidget setOnEditingComplete(void Function()? onEditingComplete) {
    _onEditingComplete = onEditingComplete;
    return this;
  }

  @override
  AppDropDownWidget setOnSubmitted(void Function(String p1)? onSubmitted) {
    _onSubmitted = onSubmitted;
    return this;
  }

  @override
  AppDropDownWidget setPadding(EdgeInsetsGeometry? padding) {
    _padding = padding;
    return this;
  }

  @override
  AppDropDownWidget setSuffixButton(SuffixButton? suffixButton) {
    _suffixButton = suffixButton;
    return this;
  }

  @override
  AppDropDownWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppDropDownWidget setTextAlignVertical(TextAlignVertical? textAlignVertical) {
    _textAlignVertical = textAlignVertical;
    return this;
  }

  @override
  AppDropDownWidget setTextCapitalization(
      TextCapitalization? textCapitalization) {
    _textCapitalization = textCapitalization;
    return this;
  }

  @override
  AppDropDownWidget setTextDirection(TextDirection? textDirection) {
    _textDirection = textDirection;
    return this;
  }

  @override
  AppDropDownWidget setTextInputAction(TextInputAction? textInputAction) {
    _textInputAction = textInputAction;
    return this;
  }

  @override
  AppDropDownWidget setDecoration(InputDecoration? inputDecoration) {
    _inputDecoration = inputDecoration;
    return this;
  }

  @override
  AppDropDownWidget setLabelText(String? labelText) {
    _labelText = labelText;
    return this;
  }

  @override
  AppDropDownWidget setPrefixIcon(Widget? prefixIcon) {
    _prefixIcon = prefixIcon;
    return this;
  }

  @override
  AppDropDownWidget setIsRequired(bool? isRequired) {
    _isRequired = isRequired;
    return this;
  }
}
