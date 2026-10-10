import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/calculate_bmi.dart';
import 'bmi_state.dart';

class BmiCubit extends Cubit<BmiState> {
  final CalculateBmi calculateBmi;

  BmiCubit({required this.calculateBmi}) : super(const BmiState(height: 100));

  void changeGender(Gender gender) {
    emit(state.copyWith(gender: gender, clearResult: true, clearError: true));
  }

  void changeHeight(double height) {
    emit(state.copyWith(height: height, clearResult: true, clearError: true));
  }

  void changeWeight(double? weight) {
    if (weight != null && (!weight.isFinite || weight < 30 || weight > 300)) {
      weight = null;
    }
    emit(
      state.copyWith(
        weight: weight,
        clearWeight: weight == null,
        clearResult: true,
        clearError: true,
      ),
    );
  }

  void setAge(int? age) {
    if (age != null && (age < 1 || age > 120)) {
      age = null;
    }
    emit(
      state.copyWith(
        age: age,
        clearAge: age == null,
        clearResult: true,
        clearError: true,
      ),
    );
  }

  bool get canCalculate {
    return state.height != null && state.weight != null && state.age != null;
  }

  void calculate() {
    if (!canCalculate) {
      emit(state.copyWith(error: 'Please complete all fields.'));
      return;
    }

    final bmiresult = calculateBmi(
      weight: state.weight!,
      height: state.height!,
    );

    emit(BmiState(gender: state.gender, bmiResult: bmiresult));
  }

  void resetBmi() {
    emit(const BmiState(height: 100));
  }
}
