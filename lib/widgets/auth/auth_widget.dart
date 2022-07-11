import 'package:flutter/material.dart';
import 'package:themoviedb/app_colors.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
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
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: ButtonLoginAsWidget(
                    icon: Icons.facebook_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            const Text(
              'Name',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.kTextColor),
            ),
            const SizedBox(height: 10),
            const TextFormFieldWidget(text: 'Enter your name'),
            const SizedBox(height: 30),
            const Text(
              'Email',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.kTextColor),
            ),
            const SizedBox(height: 10),
            const TextFormFieldWidget(text: 'Enter your email'),
            const SizedBox(height: 22),
            const Text(
              'Password',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.kTextColor),
            ),
            const SizedBox(height: 10),
            const TextFormFieldWidget(
              text: 'Enter your password',
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
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
        )),
        backgroundColor:
            MaterialStateProperty.all(AppColors.kFirstGradientColor),
        minimumSize: MaterialStateProperty.all(
          const Size(47, 47),
        ),
      ),
      onPressed: () {},
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.kTextColor,
              fontSize: 18),
        ),
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  final String text;

  const TextFormFieldWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: TextFormField(
        cursorColor: AppColors.kFirstGradientColor,
        decoration: InputDecoration(
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
          labelText: text,
          labelStyle: const TextStyle(
              color: AppColors.kSupportTextColor, fontSize: 16.0),
        ),
        style: const TextStyle(
            fontSize: 20.0, color: AppColors.kBackgroundWidgetsColor),
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
