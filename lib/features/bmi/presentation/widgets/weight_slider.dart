import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bmi_cubit.dart';
import '../cubit/bmi_state.dart';

class WeightSlider extends StatelessWidget {
  const WeightSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCubit, BmiState>(
      builder: (context, state) {
        final weight = state.weight;

        return Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text(
              'Weight',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                weight == null
                ? '-- kg' : '${weight.toInt()} kg',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Slider(
              min: 30,
              max: 300,
              divisions: 270,
              value: weight ?? 30,
              onChanged: (value) {
                context.read<BmiCubit>().changeWeight(value);
              },
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('30 kg'),
                Text('300 kg'),
              ],
            ),
          ],
        );
      },
    );
  }
}
