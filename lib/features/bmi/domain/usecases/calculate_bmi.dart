import '../entities/bmi_result.dart';

class CalculateBmi {
  BmiResult call({required double weight, required double height}) {
    if (!height.isFinite || height <= 0) {
      throw ArgumentError.value(
        height,
        'height',
        'Must be finite and greater than zero.',
      );
    }

    if (!weight.isFinite || weight <= 0) {
      throw ArgumentError.value(
        weight,
        'weight',
        'Must be finite and greater than zero.',
      );
    }

    final heightInMeters = height / 100;

    final bmi = weight / (heightInMeters * heightInMeters);

    if (bmi < 18.5) {
      return BmiResult(
        value: bmi,
        category: 'Underweight',
        description: 'Your BMI is below the normal range.',
      );
    }

    if (bmi < 25) {
      return BmiResult(
        value: bmi,
        category: 'Normal weight',
        description: 'Your BMI is within the normal range.',
      );
    }

    if (bmi < 30) {
      return BmiResult(
        value: bmi,
        category: 'Overweight',
        description: 'Your BMI is above the normal range.',
      );
    }

    return BmiResult(
      value: bmi,
      category: 'Obesity',
      description: 'Your BMI is in the obesity range.',
    );
  }
}
