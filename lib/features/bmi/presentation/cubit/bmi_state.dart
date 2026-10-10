import '../../domain/entities/bmi_result.dart';

enum Gender { male, female }

class BmiState {
  final Gender? gender;
  final double? height;
  final double? weight;
  final int? age;
  final BmiResult? bmiResult;
  final String? error;

  const BmiState({
    this.gender,
    this.height,
    this.weight,
    this.age,
    this.bmiResult,
    this.error,
  });

  BmiState copyWith({
    Gender? gender,
    double? height,
    double? weight,
    int? age,
    BmiResult? bmiResult,
    String? error,
    bool clearResult = false,
    bool clearError = false,
    bool clearAge = false,
    bool clearWeight = false,
  }) {
    return BmiState(
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: clearWeight ? null : weight ?? this.weight,
      age: clearAge ? null : age ?? this.age,
      bmiResult: clearResult ? null : bmiResult ?? this.bmiResult,
      error: clearError ? null : error ?? this.error,
    );
  }
}
