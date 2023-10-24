part of 'app_field_base_builder.dart';

class AppTextFieldWidget extends AppFieldBaseBuilder {
  @override
  Widget build(BuildContext context) {
    return TextFieldBlocBuilder(
      textFieldBloc: _bloc!,
      enableOnlyWhenFormBlocCanSubmit:
          _enableOnlyWhenFormBlocCanSubmit ?? false,
      isEnabled: _isEnabled ?? true,
      readOnly: _isReadOnly ?? false,
      errorBuilder: _errorBuilder,
      padding: _padding,
      focusNode: _focusNode,
      keyboardType: _keyboardType,
      textInputAction: _textInputAction,
      textCapitalization: _textCapitalization ?? TextCapitalization.none,
      obscureText: _obscureText,
      textAlign: _textAlign,
      textAlignVertical: _textAlignVertical,
      textDirection: _textDirection,
      autofocus: _autofocus ?? false,
      autocorrect: _autocorrect ?? true,
      autofillHints: _autofillHints,
      suffixButton: _suffixButton,
      maxLines: _maxLines ?? 1,
      minLines: _minLines,
      expands: _expands ?? false,
      maxLength: _maxLength,
      onChanged: _onChanged,
      onEditingComplete: _onEditingComplete,
      onSubmitted: _onSubmitted,
      decoration: _inputDecoration ?? const InputDecoration(),
    );
  }

  @override
  AppTextFieldWidget setAutoCorrect(bool? autoCorrect) {
    _autocorrect = autoCorrect;
    return this;
  }

  @override
  AppTextFieldWidget setAutoFillHints(Iterable<String>? autofillHints) {
    _autofillHints = autofillHints;
    return this;
  }

  @override
  AppTextFieldWidget setAutoFocus(bool? autofocus) {
    _autofocus = autofocus;
    return this;
  }

  @override
  AppTextFieldWidget setBloc(TextFieldBloc? bloc) {
    _bloc = bloc;
    return this;
  }

  @override
  AppTextFieldWidget setEnableOnlyWhenFormBlocCanSubmit(
      bool? enableOnlyWhenFormBlocCanSubmit) {
    _enableOnlyWhenFormBlocCanSubmit = enableOnlyWhenFormBlocCanSubmit;
    return this;
  }

  @override
  AppTextFieldWidget setErrorBuilder(
      String? Function(BuildContext p1, Object p2)? errorBuilder) {
    _errorBuilder = errorBuilder;
    return this;
  }

  @override
  AppTextFieldWidget setExpands(bool? expands) {
    _expands = expands;
    return this;
  }

  @override
  AppTextFieldWidget setFocusNode(FocusNode? focusNode) {
    _focusNode = focusNode;
    return this;
  }

  @override
  AppTextFieldWidget setIsEnabled(bool? isEnabled) {
    _isEnabled = isEnabled;
    return this;
  }

  @override
  AppTextFieldWidget setIsReadOnly(bool? isReadOnly) {
    _isReadOnly = isReadOnly;
    return this;
  }

  @override
  AppTextFieldWidget setKeyboardType(TextInputType? keyboardType) {
    _keyboardType = keyboardType;
    return this;
  }

  @override
  AppTextFieldWidget setMaxLength(int? maxLength) {
    _maxLength = maxLength;
    return this;
  }

  @override
  AppTextFieldWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextFieldWidget setMinLines(int? minLines) {
    _minLines = minLines;
    return this;
  }

  @override
  AppTextFieldWidget setObscureText(bool? obscureText) {
    _obscureText = obscureText;
    return this;
  }

  @override
  AppTextFieldWidget setOnChanged(void Function(String p1)? onChanged) {
    _onChanged = onChanged;
    return this;
  }

  @override
  AppTextFieldWidget setOnEditingComplete(void Function()? onEditingComplete) {
    _onEditingComplete = onEditingComplete;
    return this;
  }

  @override
  AppTextFieldWidget setOnSubmitted(void Function(String p1)? onSubmitted) {
    _onSubmitted = onSubmitted;
    return this;
  }

  @override
  AppTextFieldWidget setPadding(EdgeInsetsGeometry? padding) {
    _padding = padding;
    return this;
  }

  @override
  AppTextFieldWidget setSuffixButton(SuffixButton? suffixButton) {
    _suffixButton = suffixButton;
    return this;
  }

  @override
  AppTextFieldWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextFieldWidget setTextAlignVertical(
      TextAlignVertical? textAlignVertical) {
    _textAlignVertical = textAlignVertical;
    return this;
  }

  @override
  AppTextFieldWidget setTextCapitalization(
      TextCapitalization? textCapitalization) {
    _textCapitalization = textCapitalization;
    return this;
  }

  @override
  AppTextFieldWidget setTextDirection(TextDirection? textDirection) {
    _textDirection = textDirection;
    return this;
  }

  @override
  AppTextFieldWidget setTextInputAction(TextInputAction? textInputAction) {
    _textInputAction = textInputAction;
    return this;
  }

  @override
  AppTextFieldWidget setDecoration(InputDecoration? inputDecoration) {
    _inputDecoration = inputDecoration;
    return this;
  }
}
