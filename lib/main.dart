import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kgrill_mobile/data/repositories/authentication/authentication_repository.dart';
import 'package:kgrill_mobile/utils/local_storage/storage_utility.dart';

import 'app.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/.env");
  ///Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  ///GetX Local Storage
  await GetStorage.init();
  await TLocalStorage.init('cart_storage');

  Get.put(AuthenticationRepository());

  ///Await Splash until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const App());
}
