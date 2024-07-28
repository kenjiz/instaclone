import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/l10n/l10n.dart';
import 'package:instaclone/login/cubit/login_cubit.dart';
import 'package:shared/shared.dart';

class EmailFormField extends StatefulWidget {
  const EmailFormField({super.key});

  @override
  State<EmailFormField> createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  late Debouncer _debouncer;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()..addListener(_focusNodeListener);
    _debouncer = Debouncer();
  }

  void _focusNodeListener() {
    if (!_focusNode.hasFocus) {
      context.read<LoginCubit>().onEmailUnfocused();
    }
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_focusNodeListener)
      ..dispose();
    _controller.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailError = context.select<LoginCubit, String?>((cubit) => cubit.state.email.errorMessage);

    return AppTextField(
      filled: true,
      textController: _controller,
      focusNode: _focusNode,
      hintText: context.l10n.emailText,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      errorText: emailError,
      onChanged: (value) => _debouncer.run(
        () => context.read<LoginCubit>().onEmailChanged(value),
      ),
    );
  }
}
