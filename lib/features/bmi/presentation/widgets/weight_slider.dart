import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bmi_cubit.dart';
import '../cubit/bmi_state.dart';

class WeightSlider extends StatefulWidget {
  const WeightSlider({super.key});

  @override
  State<WeightSlider> createState() => _WeightSliderState();
}

class _WeightSliderState extends State<WeightSlider> {
  static const _poundsPerKilogram = 2.2046226218;

  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _usePounds = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: _formatWeight(context.read<BmiCubit>().state.weight),
    );
  }

  String _formatWeight(double? kilograms) {
    if (kilograms == null) return '';
    final value = _usePounds ? kilograms * _poundsPerKilogram : kilograms;
    return value == value.roundToDouble()
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(1);
  }

  void _selectUnit(bool usePounds, double? weight) {
    setState(() {
      _usePounds = usePounds;
      _controller.text = _formatWeight(weight);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCubit, BmiState>(
      builder: (context, state) {
        final weight = state.weight;
        if (!_focusNode.hasFocus && _controller.text != _formatWeight(weight)) {
          _controller.text = _formatWeight(weight);
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'WEIGHT',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            TextField(
              autofocus: false,
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
                LengthLimitingTextInputFormatter(5),
              ],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: '--',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                final enteredWeight = double.tryParse(value);
                final kilograms = enteredWeight == null
                    ? null
                    : _usePounds
                    ? enteredWeight / _poundsPerKilogram
                    : enteredWeight;
                context.read<BmiCubit>().changeWeight(
                  kilograms != null && kilograms >= 30 && kilograms <= 300
                      ? kilograms
                      : null,
                );
              },
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _WeightUnitButton(
                  label: 'kg',
                  selected: !_usePounds,
                  onTap: () => _selectUnit(false, state.weight),
                ),
                const SizedBox(width: 8),
                _WeightUnitButton(
                  label: 'lbs',
                  selected: _usePounds,
                  onTap: () => _selectUnit(true, state.weight),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _WeightUnitButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _WeightUnitButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
