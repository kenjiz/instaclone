import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/login/widget/password_form_field.dart';
import 'package:instaclone/login/widget/widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
      child: Column(
        children: [
          EmailFormField(),
          SizedBox(height: AppSpacing.md),
          PasswordFormField(),
        ],
      ),
    );
  }
}
