import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:resources/resources.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:utilities/utilities.dart';

part 'app_date_picker_widget.dart';

part 'app_dropdown_widget.dart';

part 'app_text_field_widget.dart';

abstract class AppFieldBaseBuilder {
  @protected
  TextFieldBloc<dynamic>? _bloc;
  @protected
  SuffixButton? _suffixButton;
  @protected
  Iterable<String>? _autofillHints;
  @protected
  bool? _enableOnlyWhenFormBlocCanSubmit;
  @protected
  bool? _isEnabled;
  @protected
  bool? _isReadOnly;
  @protected
  String? Function(BuildContext, Object)? _errorBuilder;
  @protected
  EdgeInsetsGeometry? _padding;
  @protected
  FocusNode? _focusNode;
  @protected
  TextInputType? _keyboardType;
  @protected
  TextInputAction? _textInputAction;
  @protected
  TextCapitalization? _textCapitalization;
  @protected
  bool? _obscureText;
  @protected
  TextAlign? _textAlign;
  @protected
  TextAlignVertical? _textAlignVertical;
  @protected
  TextDirection? _textDirection;
  @protected
  bool? _autofocus;
  @protected
  bool? _autocorrect;
  @protected
  int? _maxLines;
  @protected
  int? _minLines;
  @protected
  bool? _expands;
  @protected
  int? _maxLength;
  @protected
  InputDecoration? _inputDecoration;
  @protected
  String? _labelText;
  @protected
  Widget? _prefixIcon;
  @protected
  bool? _isRequired;
  @protected
  void Function(String)? _onChanged;
  @protected
  void Function()? _onEditingComplete;
  @protected
  void Function(String)? _onSubmitted;

  AppFieldBaseBuilder setBloc(TextFieldBloc<dynamic>? bloc);

  AppFieldBaseBuilder setSuffixButton(SuffixButton? suffixButton);

  AppFieldBaseBuilder setAutoFillHints(Iterable<String>? autofillHints);

  AppFieldBaseBuilder setEnableOnlyWhenFormBlocCanSubmit(
      bool? enableOnlyWhenFormBlocCanSubmit);

  AppFieldBaseBuilder setIsEnabled(bool? isEnabled);

  AppFieldBaseBuilder setIsReadOnly(bool? isReadOnly);

  AppFieldBaseBuilder setErrorBuilder(
      String? Function(BuildContext, Object)? errorBuilder);

  AppFieldBaseBuilder setPadding(EdgeInsetsGeometry? padding);

  AppFieldBaseBuilder setFocusNode(FocusNode? focusNode);

  AppFieldBaseBuilder setKeyboardType(TextInputType? keyboardType);

  AppFieldBaseBuilder setTextInputAction(TextInputAction? textInputAction);

  AppFieldBaseBuilder setTextCapitalization(
      TextCapitalization? textCapitalization);

  AppFieldBaseBuilder setObscureText(bool? obscureText);

  AppFieldBaseBuilder setTextAlign(TextAlign? textAlign);

  AppFieldBaseBuilder setTextAlignVertical(
      TextAlignVertical? textAlignVertical);

  AppFieldBaseBuilder setTextDirection(TextDirection? textDirection);

  AppFieldBaseBuilder setAutoFocus(bool? autofocus);

  AppFieldBaseBuilder setAutoCorrect(bool? autoCorrect);

  AppFieldBaseBuilder setMaxLines(int? maxLines);

  AppFieldBaseBuilder setMinLines(int? minLines);

  AppFieldBaseBuilder setExpands(bool? expands);

  AppFieldBaseBuilder setMaxLength(int? maxLength);

  AppFieldBaseBuilder setOnChanged(void Function(String)? onChanged);

  AppFieldBaseBuilder setOnEditingComplete(void Function()? onEditingComplete);

  AppFieldBaseBuilder setOnSubmitted(void Function(String)? onSubmitted);

  AppFieldBaseBuilder setDecoration(InputDecoration? inputDecoration);

  AppFieldBaseBuilder setLabelText(String? labelText);

  AppFieldBaseBuilder setPrefixIcon(Widget? prefixIcon);

  AppFieldBaseBuilder setIsRequired(bool? isRequired);

  Widget build(BuildContext context);
}
