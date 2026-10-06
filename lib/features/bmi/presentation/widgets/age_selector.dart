import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bmi_cubit.dart';
import '../cubit/bmi_state.dart';

class AgeSelector extends StatelessWidget {
  const AgeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCubit, BmiState>(
      builder: (context, state) {
        final cubit = context.read<BmiCubit>();

        final ages = List.generate(120, (index) => index + 1);

        return DropdownMenu<int>(
          width: double.infinity,
          label: const Text('Age'),
          hintText: 'Select your age',
          initialSelection: state.age,
          dropdownMenuEntries: ages
              .map(
                (age) =>
                    DropdownMenuEntry<int>(value: age, label: '$age years'),
              )
              .toList(),
          onSelected: (age) {
            if (age != null) {
              cubit.setAge(age);
            }
          },
        );
      },
    );
  }
}
