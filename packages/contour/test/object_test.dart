import 'package:contour/contour.dart';
import 'package:test/test.dart';

void main() {
  group('ContourObject', () {
    test('should validate basic object structure', () {
      final type = object({
        'name': string(),
        'age': number(),
        'isStudent': boolean(),
      });

      final result = type.parse({'name': 'John', 'age': 25, 'isStudent': true});

      expect(result['name'], 'John');
      expect(result['age'], 25);
      expect(result['isStudent'], true);
    });

    test('should throw on missing required fields', () {
      final type = object({'name': string(), 'age': number()});
      expect(
        () => type.parse({'name': 'John'}),
        throwsA(isA<ContourParseError>()),
      );
    });

    test('should handle nested validation errors', () {
      final type = object({'name': string().min(5), 'age': number().min(18)});

      try {
        type.parse({'name': 'Jon', 'age': 15});
        fail('Should have thrown');
      } catch (e) {
        expect(e, isA<ContourParseError>());
        final error = e as ContourParseError;
        expect(error.errors.length, 2);
      }
    });

    test('should handle extra fields when allowed', () {
      final type = object({'name': string()}, allowExtraFields: true);

      final result = type.parse({'name': 'John', 'extra': 'field'});

      expect(result['name'], 'John');
      expect(result['extra'], 'field');
    });

    test('should reject extra fields when not allowed', () {
      final type = object({'name': string()});

      expect(
        () => type.parse({'name': 'John', 'extra': 'field'}),
        throwsA(isA<ContourParseError>()),
      );
    });

    test('partial() should make all fields optional', () {
      final type = object({'name': string(), 'age': number()}).partial();

      final result = type.parse({'name': 'John'});
      expect(result['name'], 'John');
      expect(result.containsKey('age'), false);
    });

    test('pick() should only include specified fields', () {
      final type = object({
        'name': string(),
        'age': number(),
        'email': string(),
      }).pick(['name', 'age']);

      final result = type.parse({'name': 'John', 'age': 25});

      expect(result['name'], 'John');
      expect(result['age'], 25);
      expect(
        () => type.parse({
          'name': 'John',
          'age': 25,
          'email': 'john@example.com',
        }),
        throwsA(isA<ContourParseError>()),
      );
    });

    test('omit() should exclude specified fields', () {
      final type = object({
        'name': string(),
        'age': number(),
        'email': string(),
      }).omit(['email']);

      final result = type.parse({'name': 'John', 'age': 25});

      expect(result['name'], 'John');
      expect(result['age'], 25);
      expect(
        () => type.parse({
          'name': 'John',
          'age': 25,
          'email': 'john@example.com',
        }),
        throwsA(isA<ContourParseError>()),
      );
    });

    test('extend() should add new fields', () {
      final type = object({'name': string()}).extend({'age': number()});

      final result = type.parse({'name': 'John', 'age': 25});

      expect(result['name'], 'John');
      expect(result['age'], 25);
    });
  });
}
