import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class ProviderLogger extends ProviderObserver {
  final List<String>? ignoreKeywords;
  const ProviderLogger({this.ignoreKeywords});

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    for (var keyword in ignoreKeywords ?? []) {
      if ((context.provider.name?.toLowerCase() ?? "").contains(
        keyword.toLowerCase(),
      )) {
        return;
      }
    }

    debugPrint('''
{
  "provider": "${context.provider.name ?? context.provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }
}

final dioLogger = InterceptorsWrapper(
  onRequest: (options, handler) {
    debugPrint('[${options.method}] ${options.path}');
    debugPrint('REQUEST');
    if (options.method == "GET") {
      debugPrint('${options.queryParameters}');
    } else {
      debugPrint('${options.data}');
    }
    debugPrint('${options.headers}');
    debugPrint('____________________________________________');
    return handler.next(options);
  },
  onResponse: (response, handler) {
    debugPrint(
      '[${response.requestOptions.method}] ${response.requestOptions.path}',
    );
    debugPrint('RESPONSE [${response.statusCode}]');
    debugPrint('${response.data}');
    debugPrint('____________________________________________');
    return handler.next(response);
  },
  onError: (DioException e, handler) {
    debugPrint('[${e.requestOptions.method}] ${e.requestOptions.path}');
    debugPrint('ERROR  [${e.response?.statusCode}]');
    debugPrint('${e.response?.data}');
    debugPrint('____________________________________________');
    return handler.next(e);
  },
);
