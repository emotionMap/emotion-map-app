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
