import 'package:flutter/material.dart';
import 'package:noteplus_app/const/global_colors.dart';

class InputComponent extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final double? height;
  final int? minLines;
  final bool validate;
  final String? validatedMsg;
  final Function(String)? onChanged;

  const InputComponent({
    super.key,
    required this.label,
    required this.controller,
    required this.isPassword,
    required this.hintText,
    required this.validate,
    this.onChanged,
    this.height,
    this.minLines,
    this.validatedMsg,
  });

  @override
  State<InputComponent> createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _obscureText =
        widget.isPassword; // initialize only if it's a password field
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 16, color: colorScheme.onSurface),
        ),
        const SizedBox(height: 2),
        Container(
          height: widget.height ?? 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: colorScheme.surfaceContainerHighest,
            border: Border.all(
              color: widget.validate
                  ? colorScheme.error
                  : _isFocused
                      ? GlobalColors.fucusColor
                      : colorScheme.outline,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    minLines: widget.minLines ?? 1,
                    maxLines: widget.minLines == null ? 1 : null,
                    onChanged: widget.onChanged,
                    focusNode: _focusNode,
                    obscureText: widget.isPassword ? _obscureText : false,
                    controller: widget.controller,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w100,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                if (widget.isPassword)
                  IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 2,),
        widget.validate
            ? Text(
                '${widget.validatedMsg}',
                style: TextStyle(color: colorScheme.error),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}