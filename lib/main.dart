import 'package:bmi_calculator/core/di/injection.dart';
import 'package:bmi_calculator/core/theme/app_theme.dart';
import 'package:bmi_calculator/features/bmi/domain/usecases/calculate_bmi.dart';
import 'package:bmi_calculator/features/bmi/presentation/cubit/bmi_cubit.dart';
import 'package:bmi_calculator/features/bmi/presentation/screens/bmi_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupDependencies();
  runApp(const BmiCalculator());
}

class BmiCalculator extends StatelessWidget {
  const BmiCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: BlocProvider<BmiCubit>(
        create: (_) => BmiCubit(calculateBmi: getIt<CalculateBmi>()),
        child: const BmiScreen(),
      ),
    );
  }
}
