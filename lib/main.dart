import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/bloc_observer.dart';
import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/config/local_storage.dart';
import 'package:forum/src/core/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  await LocalStorage.init();
  Bloc.observer = MyBlocObserver();
  runApp(const App());
}
