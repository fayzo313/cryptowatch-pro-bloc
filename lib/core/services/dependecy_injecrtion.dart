import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';
import '../services/local_storage_service.dart';
import '../../features/markets/data/repositories/coin_repository_impl.dart';
import '../../features/markets/domain/repositories/coin_repository.dart';
import '../../features/markets/presentation/bloc/markets_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  
  // Services
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<LocalStorageService>(() => LocalStorageService(sl()));
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  // Repositories
  sl.registerLazySingleton<CoinRepository>(() => CoinRepositoryImpl(apiClient: sl(), storageService: sl()));

  // Blocs
  sl.registerFactory(() => MarketsBloc(repository: sl()));
}