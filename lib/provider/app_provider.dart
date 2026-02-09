import 'package:emotion_map_app/enum/app_mode.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_provider.g.dart';

@riverpod
AppMode appMode(Ref ref) => throw UnimplementedError();

@riverpod
FlutterSecureStorage secureStorage(Ref ref) => throw UnimplementedError();

@riverpod
SharedPreferences localStorage(Ref ref) => throw UnimplementedError();

@riverpod
String apiUrl(Ref ref) => throw UnimplementedError();
