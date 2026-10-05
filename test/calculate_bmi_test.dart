import 'package:bmi_calculator/features/bmi/domain/usecases/calculate_bmi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalculateBmi', () {
    final calculateBmi = CalculateBmi();

    test('returns the expected categories', () {
      expect(calculateBmi(weight: 50, height: 170).category, 'Underweight');
      expect(calculateBmi(weight: 65, height: 170).category, 'Normal weight');
      expect(calculateBmi(weight: 75, height: 170).category, 'Overweight');
      expect(calculateBmi(weight: 90, height: 170).category, 'Obesity');
    });

    test('rejects zero and non-finite measurements', () {
      expect(() => calculateBmi(weight: 0, height: 170), throwsArgumentError);
      expect(() => calculateBmi(weight: 65, height: 0), throwsArgumentError);
      expect(
        () => calculateBmi(weight: double.infinity, height: 170),
        throwsArgumentError,
      );
      expect(
        () => calculateBmi(weight: 65, height: double.nan),
        throwsArgumentError,
      );
    });
  });
}
