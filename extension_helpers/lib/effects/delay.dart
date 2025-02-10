part of 'effects.dart';

extension DelayExtensionHelper<T> on Function {
  Future<R?> delay<R>({
    required Duration duration,
    List<dynamic>? positionalArgs,
    Map<Symbol, dynamic>? namedArgs,
  }) async {
    await Future.delayed(duration);
    // Call the function and pass the argument if provided
    return Function.apply(this, positionalArgs ?? [], namedArgs ?? {}) as R?;
  }
}
