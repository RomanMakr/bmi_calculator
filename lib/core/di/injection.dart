import 'package:get_it/get_it.dart';

import '../../features/bmi/domain/usecases/calculate_bmi.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<CalculateBmi>(CalculateBmi.new);
}
