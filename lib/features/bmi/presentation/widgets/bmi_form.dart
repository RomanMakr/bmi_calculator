import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_clolors.dart';
import '../cubit/bmi_cubit.dart';
import '../cubit/bmi_state.dart';
import 'age_selector.dart';
import 'gender_selector.dart';
import 'height_slider.dart';
import 'weight_slider.dart';

class BmiForm extends StatelessWidget {
  const BmiForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCubit, BmiState>(
      builder: (context, state) {
        final cardColor = state.gender == Gender.female
            ? AppColors.femaleAccent
            : AppColors.card;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 168, child: const GenderSelector()),
            const SizedBox(height: 24),
            Card(
              color: cardColor,
              child: SizedBox(
                height: 168,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  child: const HeightSlider(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 168,
              child: Row(
                children: [
                  Expanded(
                    child: Card(color: cardColor, child: const WeightSlider()),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Card(
                      color: cardColor,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: AgeSelector(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  state.error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
