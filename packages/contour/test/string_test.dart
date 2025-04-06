import 'package:contour/contour.dart';
import 'package:test/test.dart';

void main() {
  group('ContourString', () {
    test('should validate basic string', () {
      final type = string();
      expect(type.parse('test'), 'test');
    });

    test('min length validation', () {
      final type = string().min(3);
      expect(() => type.parse('ab'), throwsA(isA<ContourParseError>()));
      expect(type.parse('abc'), 'abc');
    });

    test('max length validation', () {
      final type = string().max(3);
      expect(() => type.parse('abcd'), throwsA(isA<ContourParseError>()));
      expect(type.parse('abc'), 'abc');
    });

    test('exact length validation', () {
      final type = string().length(3);
      expect(() => type.parse('ab'), throwsA(isA<ContourParseError>()));
      expect(() => type.parse('abcd'), throwsA(isA<ContourParseError>()));
      expect(type.parse('abc'), 'abc');
    });

    test('pattern validation', () {
      final type = string().pattern(RegExp(r'^[a-z]+$'));
      expect(() => type.parse('123'), throwsA(isA<ContourParseError>()));
      expect(() => type.parse('ABC'), throwsA(isA<ContourParseError>()));
      expect(type.parse('abc'), 'abc');
    });

    group('transformations', () {
      test('lowercase()', () {
        final type = string().lowercase();
        expect(type.parse('ABC'), 'abc');
      });

      test('uppercase()', () {
        final type = string().uppercase();
        expect(type.parse('abc'), 'ABC');
      });

      test('trim()', () {
        final type = string().trim();
        expect(type.parse('  abc  '), 'abc');
      });

      test('replace()', () {
        final type = string().replace('-', '_');
        expect(type.parse('a-b-c'), 'a_b_c');
      });

      test('remove()', () {
        final type = string().remove('-');
        expect(type.parse('a-b-c'), 'abc');
      });

      test('append()', () {
        final type = string().append('!');
        expect(type.parse('hello'), 'hello!');
      });

      test('prepend()', () {
        final type = string().prepend('!');
        expect(type.parse('hello'), '!hello');
      });

      test('substring()', () {
        final type = string().substring(1, 4);
        expect(type.parse('hello'), 'ell');
      });
    });

    test('chaining operations', () {
      final type =
          string()
            ..min(3)
            ..max(10)
            ..trim()
            ..lowercase();

      expect(() => type.parse('ab'), throwsA(isA<ContourParseError>()));
      expect(() => type.parse('   AB   '), 'ab');
      expect(
        () => type.parse('  HELLO WORLD  '),
        throwsA(isA<ContourParseError>()),
      );
    });
  });
}
