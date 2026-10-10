import 'package:bmi_calculator/main.dart';
import 'package:bmi_calculator/core/di/injection.dart';
import 'package:bmi_calculator/core/theme/app_clolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(setupDependencies);

  testWidgets('BMI calculator form loads', (WidgetTester tester) async {
    await tester.pumpWidget(const BmiCalculator());

    expect(find.text('BMI CALCULATOR'), findsOneWidget);
    final appBar = tester.widget<AppBar>(find.byType(AppBar).first);
    expect(appBar.centerTitle, isTrue);
    final appBarTitle = tester.widget<Text>(find.text('BMI CALCULATOR'));
    expect(appBarTitle.style?.color, Colors.white);
    expect(appBarTitle.style?.fontSize, 16);
    expect(appBarTitle.style?.fontWeight, FontWeight.bold);
    expect(find.text('HEIGHT'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RichText && widget.text.toPlainText() == '100cm',
      ),
      findsOneWidget,
    );
    expect(tester.widget<Slider>(find.byType(Slider)).value, 100);
    expect(find.text('WEIGHT'), findsOneWidget);
    expect(find.text('AGE'), findsOneWidget);
    expect(find.text('kg'), findsOneWidget);
    expect(find.text('lbs'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(tester.testTextInput.isVisible, isFalse);
    final calculateButton = find.ancestor(
      of: find.text('CALCULATE'),
      matching: find.byType(ElevatedButton),
    );
    expect(tester.widget<ElevatedButton>(calculateButton).onPressed, isNull);

    await tester.tap(find.text('FEMALE'));
    await tester.pumpAndSettle();
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is AnimatedContainer &&
            (widget.decoration as BoxDecoration?)?.color ==
                AppColors.femaleAccent,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Card && widget.color == AppColors.femaleAccent,
      ),
      findsNWidgets(3),
    );

    await tester.tap(find.text('MALE'));
    await tester.pumpAndSettle();
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is AnimatedContainer &&
            (widget.decoration as BoxDecoration?)?.color == AppColors.card,
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('FEMALE'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), '50');
    expect(find.text('50'), findsOneWidget);
    await tester.enterText(find.byType(TextField).at(1), '27');
    expect(find.text('27'), findsOneWidget);
    expect(tester.testTextInput.isVisible, isTrue);

    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    await tester.drag(find.byType(Slider), const Offset(10, 0));
    await tester.pumpAndSettle();
    expect(tester.widget<ElevatedButton>(calculateButton).onPressed, isNotNull);

    await tester.tap(find.text('CALCULATE'));
    await tester.pumpAndSettle();

    expect(tester.testTextInput.isVisible, isFalse);
    expect(find.text('Your Result'), findsOneWidget);
    expect(find.text('RECALCULATE'), findsOneWidget);
    final resultCategory = tester.widget<Text>(find.text('Normal weight'));
    expect(resultCategory.style?.color, Colors.white);
    expect(resultCategory.style?.fontWeight, FontWeight.bold);
    final resultDescription = tester.widget<Text>(
      find.text('Your BMI is within the normal range.'),
    );
    expect(resultDescription.style?.color, Colors.white);
    expect(resultDescription.style?.fontWeight, FontWeight.bold);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            (widget.decoration as BoxDecoration?)?.color ==
                AppColors.femaleAccent,
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('RECALCULATE'));
    await tester.pumpAndSettle();
    expect(tester.testTextInput.isVisible, isFalse);
    expect(find.text('HEIGHT'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RichText && widget.text.toPlainText() == '100cm',
      ),
      findsOneWidget,
    );
    expect(find.text('WEIGHT'), findsOneWidget);
    expect(find.text('--'), findsNWidgets(2));
    expect(find.text('50'), findsNothing);
    expect(find.text('27'), findsNothing);
    expect(tester.widget<ElevatedButton>(calculateButton).onPressed, isNull);
  });

  testWidgets('BMI can be calculated without selecting gender', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BmiCalculator());

    await tester.enterText(find.byType(TextField).at(0), '50');
    await tester.enterText(find.byType(TextField).at(1), '27');
    tester.testTextInput.hide();
    await tester.pumpAndSettle();

    final calculateButton = find.ancestor(
      of: find.text('CALCULATE'),
      matching: find.byType(ElevatedButton),
    );
    expect(tester.widget<ElevatedButton>(calculateButton).onPressed, isNotNull);

    await tester.tap(find.text('CALCULATE'));
    await tester.pumpAndSettle();

    expect(find.text('Your Result'), findsOneWidget);
    expect(find.text('50.0'), findsOneWidget);
  });
}
