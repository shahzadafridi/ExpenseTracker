import 'package:image_picker/image_picker.dart';
import '../app/app_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance.registerLazySingleton<AppsPreferences>(
          () => AppsPreferences(sharedPreferences: instance()));

  // Image Picker
  instance.registerFactory<ImagePicker>(() => ImagePicker());
}
