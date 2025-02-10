part of 'effects.dart';

extension ConditionalExtension on bool {
  T when<T>({required T use, required T elseUse}) {
    if (this == true) {
      return use;
    } else {
      return elseUse;
    }
  }

  T? whenNull<T>({required T use, required T? elseUse}) {
    if (this == true) {
      return use;
    } else {
      return elseUse;
    }
  }

  T? whenOnly<T>({required T use}) {
    if (this == true) {
      return use;
    } else {
      return null;
    }
  }
}

extension ConditionalOpExtension<T> on T? {
  U? when<U>({required U use, U? elseUse}) {
    if (this != null) {
      return use;
    } else {
      return elseUse;
    }
  }
}
