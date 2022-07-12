import 'package:flutter/material.dart';
import 'package:themoviedb/theme/app_colors.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leading: IconButton(
          splashRadius: 24,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.kTextColor,
          ),
          onPressed: () {},
        ),
        title: const Text(
          'Sign up',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        ),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mainTextStyle = TextStyle(
        fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.kTextColor);
    return SingleChildScrollView(
      // physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text('Sign up with one of following options',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: AppColors.kSupportTextColor)),
            const SizedBox(height: 42),
            Row(
              children: const [
                Expanded(
                  child: ButtonLoginAsWidget(
                    icon: Icons.apple_rounded,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: ButtonLoginAsWidget(
                    icon: Icons.facebook_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            const Text('Name', style: mainTextStyle),
            const SizedBox(height: 10),
            const TextFormFieldWidget(text: 'Enter your name'),
            const SizedBox(height: 30),
            const Text('Email', style: mainTextStyle),
            const SizedBox(height: 10),
            const TextFormFieldWidget(text: 'Enter your email'),
            const SizedBox(height: 22),
            const Text('Password', style: mainTextStyle),
            const SizedBox(height: 10),
            const TextFormFieldWidget(
              text: 'Enter your password',
              password: true,
            ),
            const SizedBox(height: 53),
            const ButtonWidget(
              text: 'Create Account',
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: AppColors.kSupportTextColor),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: AppColors.kTextColor,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.kTextColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;

  const ButtonWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        //   ElevatedButton(
        //   style: ButtonStyle(
        //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //         RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(11.0),
        //     )),
        //     backgroundColor:
        //         MaterialStateProperty.all(AppColors.kFirstGradientColor),
        //     minimumSize: MaterialStateProperty.all(
        //       const Size(47, 47),
        //     ),
        //   ),
        //   onPressed: () {},
        //   child: Center(
        //     child: Text(
        //       text,
        //       style: const TextStyle(
        //           fontWeight: FontWeight.w700,
        //           color: AppColors.kTextColor,
        //           fontSize: 18),
        //     ),
        //   ),
        // );
        Container(
      width: double.infinity,
      height: 47,
      decoration: ShapeDecoration(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.kSecondGradientColor,
            AppColors.kFirstGradientColor
          ],
        ),
      ),
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0)),
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.kTextColor,
              fontSize: 18),
        ),
        onPressed: () {},
      ),
    );
  }
}

class TextFormFieldWidget extends StatefulWidget {
  final String text;
  final bool? password;

  const TextFormFieldWidget({
    Key? key,
    required this.text,
    this.password,
  }) : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool _isObscure = true;

  void _toggle() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: TextFormField(
        obscureText: widget.password == true
            ? (_isObscure == true ? true : false)
            : false,
        obscuringCharacter: "·",
        cursorColor: AppColors.kIconColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15.0),
          suffixIcon: widget.password == true
              ? IconButton(
                  splashRadius: 24,
                  color: AppColors.kIconColor,
                  icon: Icon(_isObscure == true
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  onPressed: () {
                    setState(() {
                      _toggle();
                    });
                  },
                )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: AppColors.kBackgroundWidgetsColor,
          filled: true,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(11.0),
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(11.0),
            ),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          labelText: widget.text,
          labelStyle: const TextStyle(
              color: AppColors.kSupportTextColor, fontSize: 16.0),
        ),
        style:
            const TextStyle(fontSize: 16.0, color: AppColors.kSupportTextColor),
      ),
    );
  }
}

class ButtonLoginAsWidget extends StatelessWidget {
  final IconData icon;

  const ButtonLoginAsWidget({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.0),
          )),
          backgroundColor:
              MaterialStateProperty.all(AppColors.kBackgroundWidgetsColor),
          minimumSize: MaterialStateProperty.all(const Size(57, 57))),
      child: Center(
        child: Icon(icon, size: 24, color: AppColors.kIconColor),
      ),
    );
  }
}
