import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bmi_cubit.dart';
import '../cubit/bmi_state.dart';

class CalculateButton extends StatelessWidget {
  const CalculateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCubit, BmiState>(
      builder: (context, state) {
        final canCalculate = context.read<BmiCubit>().canCalculate;

        return ElevatedButton(
          onPressed: canCalculate ? () {
            context.read<BmiCubit>().calculate();
          } : null,
          child: const Text(
              'CALCULATE BMI',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
          ),
          );
      },
    );
  }
}
