import 'package:bmi_calculator/features/bmi/presentation/widgets/bmi_result_cart.dart';
import 'package:bmi_calculator/core/theme/app_clolors.dart';
import 'package:flutter/material.dart';

import '../widgets/reset_button.dart';
import '../../domain/entities/bmi_result.dart';
import '../cubit/bmi_state.dart';

class ResultScreen extends StatelessWidget {
  final BmiResult result;
  final Gender? gender;

  const ResultScreen({super.key, required this.result, required this.gender});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Your Result',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Expanded(
                child: BmiResultCard(
                  result: result,
                  backgroundColor: gender == Gender.female
                      ? AppColors.femaleAccent
                      : AppColors.card,
                ),
              ),
              const SizedBox(height: 24),
              const ResetBmiButton(),
            ],
          ),
        ),
      ),
    );
  }
}
