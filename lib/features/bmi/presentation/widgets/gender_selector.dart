import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_clolors.dart';
import '../cubit/bmi_cubit.dart';
import '../cubit/bmi_state.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCubit, BmiState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _GenderCard(
                title: 'Male',
                icon: Icons.male,
                selected: state.gender == Gender.male,
                selectedColor: AppColors.card,
                onTap: () {
                  context.read<BmiCubit>().changeGender(Gender.male);
                },
              ),
            ),

            const SizedBox(width: 24),
            Expanded(
              child: _GenderCard(
                title: 'Female',
                icon: Icons.female,
                selected: state.gender == Gender.female,
                selectedColor: AppColors.femaleAccent,
                onTap: () {
                  context.read<BmiCubit>().changeGender(Gender.female);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GenderCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _GenderCard({
    required this.title,
    required this.icon,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? selectedColor : AppColors.cardUnselected,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: selected ? Colors.white : AppColors.textPrimary,
            ),

            const SizedBox(height: 10),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
