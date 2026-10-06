import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/calculate_bmi.dart';
import 'bmi_state.dart';

class BmiCubit extends Cubit<BmiState> {
  final CalculateBmi calculateBmi;

  BmiCubit({required this.calculateBmi}) : super(const BmiState());

  void changeGender(Gender gender) {
    emit(state.copyWith(gender: gender, clearResult: true, clearError: true));
  }

  void changeHeight(double height) {
    emit(state.copyWith(height: height, clearResult: true, clearError: true));
  }

  void changeWeight(double weight) {
    emit(state.copyWith(weight: weight, clearResult: true, clearError: true));
  }

  void setAge(int age) {
    if (age < 1 || age > 120) {
      return;
    }
    emit(state.copyWith(age: age, clearResult: true, clearError: true));
  }

  bool get canCalculate {
    return state.gender != null &&
        state.height != null &&
        state.weight != null &&
        state.age != null;
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

    emit(state.copyWith(bmiResult: bmiresult, clearError: true));
  }

  void resetBmi() {
    emit(const BmiState());
  }
}
