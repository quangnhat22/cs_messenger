import 'package:app/components/features/message/input/attachment_button_widget.dart';
import 'package:app/components/features/message/input/input_text_field_controller.dart';
import 'package:app/components/features/message/input/reply_message_widget.dart';
import 'package:app/components/features/message/input/send_button_widget.dart';
import 'package:app/components/features/message/model/input_clear_mode.dart';
import 'package:app/components/features/message/model/send_button_visibility_mode.dart';
import 'package:app/components/features/message/utils/message_utils.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    super.key,
    this.isAttachmentUploading,
    this.onAttachmentPressed,
    required this.onSendPressed,
    this.replyMessage,
    this.onRemoveReplyMessage,
    this.options = const InputOptions(),
  });

  /// Whether attachment is uploading. Will replace attachment button with a
  /// [CircularProgressIndicator]. Since we don't have libraries for
  /// managing media in dependencies we have no way of knowing if
  /// something is uploading so you need to set this manually.
  final bool? isAttachmentUploading;

  /// See [AttachmentButton.onPressed].
  final VoidCallback? onAttachmentPressed;

  /// Will be called on [SendButton] tap. Has [PartialTextModel] which can
  /// be transformed to [TextMessageModel] and added to the messages list.
  final void Function(TextMessageParam) onSendPressed;

  /// Customisation options for the [Input].
  final InputOptions options;

  final IMessageModel? replyMessage;
  final void Function()? onRemoveReplyMessage;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late TextEditingController _textController;

  bool _sendButtonVisible = false;

  late final _inputFocusNode = FocusNode(
    onKeyEvent: (node, event) {
      if (event.physicalKey == PhysicalKeyboardKey.enter &&
          !HardwareKeyboard.instance.physicalKeysPressed.any(
            (el) => <PhysicalKeyboardKey>{
              PhysicalKeyboardKey.shiftLeft,
              PhysicalKeyboardKey.shiftRight,
            }.contains(el),
          )) {
        if (kIsWeb && _textController.value.isComposingRangeValid) {
          return KeyEventResult.ignored;
        }
        if (event is KeyDownEvent) {
          _handleSendPressed();
        }
        return KeyEventResult.handled;
      } else {
        return KeyEventResult.ignored;
      }
    },
  );

  @override
  void initState() {
    super.initState();
    _textController =
        widget.options.textEditingController ?? InputTextFieldController();
    _handleSendButtonVisibilityModeChange();
  }

  @override
  void didUpdateWidget(covariant InputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.options.sendButtonVisibilityMode !=
        oldWidget.options.sendButtonVisibilityMode) {
      _handleSendButtonVisibilityModeChange();
    }
  }

  @override
  void dispose() {
    _inputFocusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _inputFocusNode.requestFocus(),
      child: _inputBuilder(),
    );
  }

  Widget _inputBuilder() {
    final query = MediaQuery.of(context);

    final safeAreaInsets = MessageUtils.isMobile
        ? EdgeInsets.fromLTRB(
            query.padding.left,
            AppSizeExt.of.majorPaddingScale(1),
            query.padding.right,
            AppSizeExt.of.majorPaddingScale(1) + query.padding.bottom,
          )
        : EdgeInsets.zero;

    return Focus(
      autofocus: !widget.options.autofocus,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Material(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
          elevation: 0,
          child: Container(
            decoration: null,
            padding: safeAreaInsets,
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                if (widget.onAttachmentPressed != null && !_sendButtonVisible)
                  AttachmentButton(
                    isLoading: widget.isAttachmentUploading ?? false,
                    onPressed: widget.onAttachmentPressed,
                    padding: EdgeInsets.zero,
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      widget.onAttachmentPressed != null
                          ? _sendButtonVisible
                              ? AppSizeExt.of.majorPaddingScale(2)
                              : AppSizeExt.of.majorPaddingScale(4)
                          : AppSizeExt.of.majorPaddingScale(6),
                      AppSizeExt.of.majorScale(0),
                      widget.onAttachmentPressed != null
                          ? _sendButtonVisible
                              ? AppSizeExt.of.majorPaddingScale(0)
                              : AppSizeExt.of.majorPaddingScale(4)
                          : AppSizeExt.of.majorPaddingScale(6),
                      AppSizeExt.of.majorScale(0),
                    ),
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInQuad,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              AppSizeExt.of.majorScale(5),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.all(AppSizeExt.of.majorScale(1)),
                        child: Column(
                          children: [
                            if (widget.replyMessage != null)
                              ReplyMessage(
                                messageReply: ReplyMessageModel(
                                  id: widget.replyMessage!.id,
                                  roomId: widget.replyMessage?.roomId,
                                  clientId: widget.replyMessage?.clientId,
                                  content: widget.replyMessage?.content,
                                  authorName: widget.replyMessage?.author.name,
                                ),
                                onRemoveReplyMessage: () {
                                  widget.onRemoveReplyMessage?.call();
                                },
                              ),
                            TextField(
                              enabled: widget.options.enabled,
                              autocorrect: widget.options.autocorrect,
                              autofocus: widget.options.autofocus,
                              enableSuggestions:
                                  widget.options.enableSuggestions,
                              controller: _textController,
                              cursorColor:
                                  Theme.of(context).colorScheme.outline,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 0.0,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      AppSizeExt.of.majorScale(4),
                                    ),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: AppSizeExt.of.majorPaddingScale(2),
                                  horizontal:
                                      AppSizeExt.of.majorPaddingScale(3),
                                ),
                                isCollapsed: true,
                                filled: true,
                                fillColor:
                                    Theme.of(context).colorScheme.background,
                                //TODO: support en vi
                                hintText: 'Type a message',
                              ),
                              focusNode: _inputFocusNode,
                              keyboardType: widget.options.keyboardType,
                              maxLines: 5,
                              minLines: 1,
                              onChanged: widget.options.onTextChanged,
                              onTap: widget.options.onTextFieldTap,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 0 + 0 + 24,
                  ),
                  child: Visibility(
                    visible: _sendButtonVisible,
                    child: SendButton(
                        onPressed: _handleSendPressed,
                        padding:
                            const EdgeInsets.fromLTRB(24, 20, 24, 20).copyWith(
                          left: 20,
                          right: 20,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSendButtonVisibilityModeChange() {
    _textController.removeListener(_handleTextControllerChange);
    if (widget.options.sendButtonVisibilityMode ==
        SendButtonVisibilityMode.hidden) {
      _sendButtonVisible = false;
    } else if (widget.options.sendButtonVisibilityMode ==
        SendButtonVisibilityMode.editing) {
      _sendButtonVisible = _textController.text.trim() != '';
      _textController.addListener(_handleTextControllerChange);
    } else {
      _sendButtonVisible = true;
    }
  }

  void _handleTextControllerChange() {
    if (_textController.value.isComposingRangeValid) {
      return;
    }
    setState(() {
      _sendButtonVisible = _textController.text.trim() != '';
    });
  }

  void _handleSendPressed() {
    final trimmedText = _textController.text.trim();
    if (trimmedText != '') {
      final partialText = TextMessageParam(text: trimmedText);
      widget.onSendPressed(partialText);

      if (widget.options.inputClearMode == InputClearMode.always) {
        _textController.clear();
      }
    }
  }
}

@immutable
class InputOptions {
  const InputOptions({
    this.inputClearMode = InputClearMode.always,
    this.keyboardType = TextInputType.multiline,
    this.onTextChanged,
    this.onTextFieldTap,
    this.sendButtonVisibilityMode = SendButtonVisibilityMode.editing,
    this.textEditingController,
    this.autocorrect = true,
    this.autofocus = false,
    this.enableSuggestions = true,
    this.enabled = true,
  });

  /// Controls the [Input] clear behavior. Defaults to [InputClearMode.always].
  final InputClearMode inputClearMode;

  /// Controls the [Input] keyboard type. Defaults to [TextInputType.multiline].
  final TextInputType keyboardType;

  /// Will be called whenever the text inside [TextField] changes.
  final void Function(String)? onTextChanged;

  /// Will be called on [TextField] tap.
  final VoidCallback? onTextFieldTap;

  /// Controls the visibility behavior of the [SendButton] based on the
  /// [TextField] state inside the [Input] widget.
  /// Defaults to [SendButtonVisibilityMode.editing].
  final SendButtonVisibilityMode sendButtonVisibilityMode;

  /// Custom [TextEditingController]. If not provided, defaults to the
  /// [InputTextFieldController], which extends [TextEditingController] and has
  /// additional fatures like markdown support. If you want to keep additional
  /// features but still need some methods from the default [TextEditingController],
  /// you can create your own [InputTextFieldController] (imported from this lib)
  /// and pass it here.
  final TextEditingController? textEditingController;

  /// Controls the [TextInput] autocorrect behavior. Defaults to [true].
  final bool autocorrect;

  /// Whether [TextInput] should have focus. Defaults to [false].
  final bool autofocus;

  /// Controls the [TextInput] enableSuggestions behavior. Defaults to [true].
  final bool enableSuggestions;

  /// Controls the [TextInput] enabled behavior. Defaults to [true].
  final bool enabled;
}
