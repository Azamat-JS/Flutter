import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoggerRiverpod extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase providerBase,
    Object? previousValue,
    Object? newValue,
    ProviderContainer providerContainer,
  ) {
    print('$providerBase $previousValue $newValue $providerContainer');
  }

  @override
  void didAddProvider(
    ProviderBase<dynamic> provider,
    Object? value,
    ProviderContainer container,
  ) {
    // TODO: implement didAddProvider
    super.didAddProvider(provider, value, container);
  }

  @override
  void didDisposeProvider(
    ProviderBase<dynamic> provider,
    ProviderContainer containers,
  ) {
    // TODO: implement didDisposeProvider
    super.didDisposeProvider(provider, containers);
  }
}
