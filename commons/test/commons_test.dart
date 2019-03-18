/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:commons/commons.dart';
import "package:test/test.dart";

void main() {
  group("checkNotNull", () {
    test("returns passed in value if it is not null", () {
      Object obj = new Object();
      expect(checkNotNull(obj), same(obj));
    });

    test("throws error with no message when value is null and message is not provided", () {
      expect(() => checkNotNull(null), throwsA((ArgumentError e) => e.message == null));
    });

    test("throws error with custom message when value is null and custom message is provided", () {
      expect(() => checkNotNull(null, "a custom message"), throwsA((ArgumentError e) => e.message == "a custom message"));
    });
  });

  group("checkArgument", () {
    test("does not throw error when expression is true", () {
      expect(() => checkArgument(true), returnsNormally);
    });

    test("throws error when expression is null", () {
      expect(() => checkArgument(null), throwsA((ArgumentError e) => e.message == "Expression cannot be null"));
    });

    test("throws error with no message when expression is false and message is not provided", () {
      expect(() => checkArgument(false), throwsA((ArgumentError e) => e.message == null));
    });

    test("throws error with custom message when expression is false and custom message is provided", () {
      expect(() => checkArgument(false, "a custom message"), throwsA((ArgumentError e) => e.message == "a custom message"));
    });
  });
}
