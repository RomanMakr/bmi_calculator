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
          children: [
            Expanded(
              child: _GenderCard(
                title: 'Male',
                icon: Icons.male,
                selected: state.gender == Gender.male,
                onTap: () {
                  context.read<BmiCubit>().changeGender(Gender.male);
                },
              ),
            ),

            const SizedBox(width: 16),
            Expanded(
              child: _GenderCard(
                title: 'Female',
                icon: Icons.female,
                selected: state.gender == Gender.female,
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
  final VoidCallback onTap;

  const _GenderCard({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.card,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.transparent,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 52,
              color: selected ? AppColors.card : AppColors.textPrimary,
            ),

            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: selected ? AppColors.card : AppColors.textPrimary,
              )
            )
          ],
        ),
      ),
    );
  }
}
