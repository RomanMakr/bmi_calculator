import 'package:bmi_calculator/features/bmi/presentation/widgets/bmi_form.dart';
import 'package:bmi_calculator/features/bmi/presentation/widgets/calculate_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bmi_cubit.dart';
import '../cubit/bmi_state.dart';
import 'result_screen.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BmiCubit, BmiState>(
      listenWhen: (previous, current) =>
          previous.bmiResult != current.bmiResult && current.bmiResult != null,
      listener: (context, state) {
        FocusManager.instance.primaryFocus?.unfocus();
        final cubit = context.read<BmiCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: cubit,
              child: ResultScreen(
                result: state.bmiResult!,
                gender: state.gender,
              ),
            ),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 36,
          centerTitle: true,
          title: const Text(
            'BMI CALCULATOR',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight - 20,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 700),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [BmiForm()],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: const CalculateButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
