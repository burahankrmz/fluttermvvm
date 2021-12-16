import 'package:flutteradvancedmvvm/app/app_prefs.dart';
import 'package:flutteradvancedmvvm/data/data_source/locale_data_source.dart';
import 'package:flutteradvancedmvvm/data/data_source/remote_data_source.dart';
import 'package:flutteradvancedmvvm/data/network/app_api.dart';
import 'package:flutteradvancedmvvm/data/network/dio_factory.dart';
import 'package:flutteradvancedmvvm/data/network/network_info.dart';
import 'package:flutteradvancedmvvm/data/repository/repository_impl.dart';
import 'package:flutteradvancedmvvm/domain/repository/repository.dart';
import 'package:flutteradvancedmvvm/domain/usecase/forgotpassword_usecase.dart';
import 'package:flutteradvancedmvvm/domain/usecase/home_usecase.dart';
import 'package:flutteradvancedmvvm/domain/usecase/login_usecase.dart';
import 'package:flutteradvancedmvvm/domain/usecase/register_usecase.dart';
import 'package:flutteradvancedmvvm/domain/usecase/store_details_usecase.dart';
import 'package:flutteradvancedmvvm/presentation/authentication/forgot_password/viewmodel/forgot_password_viewmodel.dart';
import 'package:flutteradvancedmvvm/presentation/authentication/login/viewmodel/login_viewmodel.dart';
import 'package:flutteradvancedmvvm/presentation/authentication/register/viewmodel/register_viewmodel.dart';
import 'package:flutteradvancedmvvm/presentation/main/home/viewmodel/home_viewmodel.dart';
import 'package:flutteradvancedmvvm/presentation/store_details/view_model/store_details_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  //? shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //? app prefs instance
  instance.registerLazySingleton<AppPrefences>(() => AppPrefences(instance()));

  //? network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementer());
  //  instance.registerLazySingleton<NetworkInfo>(
  //  () => NetworkInfoImplementer(DataConnectionChecker()));

  //? dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //? app service
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //? remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  //? locale data source
  instance.registerLazySingleton<LocaleDataSource>(
      () => LocaleDataSourceImpl());

  //? repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(),instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUsecase>()) {
    instance
        .registerFactory<RegisterUsecase>(() => RegisterUsecase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(
        () => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(
        () => HomeViewModel(instance()));
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
        () => StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(
        () => StoreDetailsViewModel(instance()));
  }
}

resetModules() {
  instance.reset(dispose: false);
  initAppModule();
  initHomeModule();
  initLoginModule();
  initRegisterModule();
  initForgotPasswordModule();
  initStoreDetailsModule();
}