/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

part of commons;

/// Represents a pair.
class Pair<T1, T2> {
  /// Returns the first item of the pair
  final T1 first;

  /// Returns the second item of the pair
  final T2 second;

  /// Creates a new pair value with the specified items.
  const Pair(this.first, this.second);

  /// Returns a pair with the first item set to the specified value.
  Pair<T1, T2> withItem1(T1 v) {
    return new Pair<T1, T2>(v, second);
  }

  /// Returns a pair with the second item set to the specified value.
  Pair<T1, T2> withItem2(T2 v) {
    return new Pair<T1, T2>(first, v);
  }

  @override
  String toString() {
    return 'Pair{item1: $first, item2: $second}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Pair &&
              runtimeType == other.runtimeType &&
              first == other.first &&
              second == other.second;

  @override
  int get hashCode =>
      first.hashCode ^
      second.hashCode;

}