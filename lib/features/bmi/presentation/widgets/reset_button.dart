import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bmi_cubit.dart';

class ResetBmiButton extends StatelessWidget {
  const ResetBmiButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        context.read<BmiCubit>().resetBmi();
        Navigator.pop(context);
      },
      child:  const Text('CALCULATE AGAIN'),
    );
  }
}
