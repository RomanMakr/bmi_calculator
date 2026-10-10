import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bmi_cubit.dart';

class ResetBmiButton extends StatelessWidget {
  const ResetBmiButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        context.read<BmiCubit>().resetBmi();
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(80),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.zero,
            bottom: Radius.circular(24),
          ),
        ),
      ),
      child: const Text(
        'RECALCULATE',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
