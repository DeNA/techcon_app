/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import "package:test/test.dart";
import "package:commons/commons.dart";

main() {
  
  var someValue = null.toString();
  
  group("firstNonNull()", () {
    test("returns first argument when first is not null and second is null", () {
      expect(Objects.firstNonNull("first", null), "first");
    });
    
    test("returns first argument when first is not null and second is not null", () {
      expect(Objects.firstNonNull("first", "second"), "first");
    });

    test("returns second argument when first is null and second is not null", () {
      expect(Objects.firstNonNull(null, "second"), "second");
    });
    
    test("throws error when both arguments are null", () {
      expect(() => Objects.firstNonNull(null, null), throwsArgumentError);
    });
  });
  
  group("nullSafeInvoke()", () {
    test("returns null if initial variable is null", () {
      var list = null;
      expect(Objects.nullSafeInvoke(() => list.reversed.isEmpty), isNull);
    });
    
    test("returns null if chained call results in a null part way through", () {
      var simpleTest = new _SimpleTestClass();
      expect(Objects.nullSafeInvoke(() => simpleTest.nested.nested), isNull);
    });
  });
  
  group("isPrimitive()", () {
    test("returns true for int", () {
      expect(Objects.isPrimitive(1), isTrue);
    });
    test("returns true for double", () {
      expect(Objects.isPrimitive(2.0), isTrue);
    });
    test("returns true for bool", () {
      expect(Objects.isPrimitive(false), isTrue);
    });
    test("returns true for null", () {
      expect(Objects.isPrimitive(null), isTrue);
    });
    test("returns true for String", () {
      expect(Objects.isPrimitive("string"), isTrue);
    });
  });
}

class _SimpleTestClass {
  _SimpleTestClass nested = null;
}