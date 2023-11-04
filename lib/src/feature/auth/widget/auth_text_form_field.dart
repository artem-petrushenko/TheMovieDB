import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextFormField extends StatefulWidget {
  const AuthTextFormField({
    Key? key,
    this.autocorrect = false,
    this.obscureText = false,
    this.enableSuggestions = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.keyboardType,
    this.suffixIcon,
    this.suffixIconColor,
    this.hintText,
  }) : super(key: key);

  final String? hintText;
  final bool autocorrect;
  final bool obscureText;
  final bool enableSuggestions;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final Color? suffixIconColor;

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final inputDecoration = InputDecoration(
      hintText: widget.hintText,
      suffixIcon: widget.suffixIcon,
      suffixIconColor: widget.suffixIconColor,
      hintStyle: GoogleFonts.montserrat(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.60),
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
      //TODO: STYLE NOT WORKING
      labelStyle: GoogleFonts.montserrat(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2.0,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2.0,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2.0,
        ),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.onBackground,
          width: 2.0,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.onBackground,
          width: 2.0,
        ),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.onBackground,
          width: 2.0,
        ),
      ),
    );

    return TextFormField(
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      decoration: inputDecoration,
    );
  }
}
