/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

part of commons;

class Objects {
  _Objects() {}

  /**
   * Returns the first non-null argument.  If both arguments are null, an [ArgumentError] is thrown.
   */
  static firstNonNull(first, second) {
    if (first != null) {
      return first;
    } else if (second != null) {
      return second;
    }

    throw new ArgumentError("Both arguments were null.");
  }

  /**
   * Invokes a function and returns null if the function would result in [NoSuchMethodError] due to a null value.
   * This function can be used to execute a function chain without needing to check for nulls.  For example:
   *
   * var list = null;
   * nullSafeInvoke(() => list.reversed.isEmpty); //returns null
   *
   * NOTE: This function works by catching [NoSuchMethodError] errors because they are thrown when a method is called on a null
   * object.  This means that these errors will not be thrown or propagate if they occur.
   */
  static nullSafeInvoke(Function f) {
    try {
      return f();
    } on NoSuchMethodError catch(e) {
      return null;
    }
    return null;
  }

  /**
   * Determines whether [object] is a primitive type.
   *
   * Primitive types detected by this function are: [null], [num] (including [int] and [double]), [String], and [bool].
   */
  static bool isPrimitive(object) {
    return identical(object, null) || object is num || object is String ||
        identical(object, true) || identical(object, false);
  }
}