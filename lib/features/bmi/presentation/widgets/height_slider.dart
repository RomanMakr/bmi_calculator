import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bmi_cubit.dart';
import '../cubit/bmi_state.dart';

class HeightSlider extends StatelessWidget {
  const HeightSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCubit, BmiState>(
      builder: (context, state) {
        final height = state.height;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Height',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                height == null
                ? '-- cm' : '${height.toInt()} cm',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Slider(
              min: 100,
              max: 220,
              divisions: 120,
              value: height ?? 100,
              onChanged: ( value) {
                context.read<BmiCubit>().changeHeight(value);
              },
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('100 cm'),
                Text('220 cm'),
              ],
            )
          ],
        );
      },
    );
  }
}
