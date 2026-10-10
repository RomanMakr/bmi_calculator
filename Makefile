.PHONY: get run test analyze format clean

get:
	flutter pub get

run:
	flutter run

test:
	flutter test

analyze:
	flutter analyze

format:
	dart format .

clean:
	flutter clean
