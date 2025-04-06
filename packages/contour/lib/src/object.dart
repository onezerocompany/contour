import 'package:contour/src/type.dart';

class ContourObject extends ContourType<Map<String, dynamic>> {
  final Map<String, ContourType> schema;
  final bool allowExtraFields;

  ContourObject(this.schema, {this.allowExtraFields = false});

  @override
  Map<String, dynamic> parse(Map<String, dynamic> value) {
    List<ContourError> errors = [];
    Map<String, dynamic> result = {};

    // Check for required fields and validate existing ones
    for (var entry in schema.entries) {
      final key = entry.key;
      final type = entry.value;

      if (!value.containsKey(key)) {
        errors.add(
          ContourError(
            message: 'Required field "$key" is missing',
            name: 'MissingField',
          ),
        );
        continue;
      }

      try {
        result[key] = type.parse(value[key]);
      } catch (e) {
        if (e is ContourParseError) {
          errors.addAll(
            e.errors.map(
              (error) => ContourError(
                message: '${error.message} (in field "$key")',
                name: error.name,
              ),
            ),
          );
        } else if (e is ContourError) {
          errors.add(
            ContourError(
              message: '${e.message} (in field "$key")',
              name: e.name,
            ),
          );
        }
      }
    }

    // Check for extra fields
    if (!allowExtraFields) {
      for (var key in value.keys) {
        if (!schema.containsKey(key)) {
          errors.add(
            ContourError(
              message: 'Unknown field "$key" is not allowed',
              name: 'ExtraField',
            ),
          );
        }
      }
    }

    if (errors.isNotEmpty) {
      throw ContourParseError(errors);
    }

    // Copy over any allowed extra fields
    if (allowExtraFields) {
      for (var key in value.keys) {
        if (!schema.containsKey(key)) {
          result[key] = value[key];
        }
      }
    }

    return super.parse(result);
  }

  ContourObject omit(List<String> keys) {
    final omittedSchema = Map<String, ContourType>.fromEntries(
      schema.entries.where((e) => !keys.contains(e.key)),
    );
    return ContourObject(omittedSchema, allowExtraFields: allowExtraFields);
  }

  ContourObject extend(Map<String, ContourType> extension) {
    final extendedSchema = Map<String, ContourType>.from(schema)
      ..addAll(extension);
    return ContourObject(extendedSchema, allowExtraFields: allowExtraFields);
  }
}

ContourObject object(
  Map<String, ContourType> schema, {
  bool allowExtraFields = false,
}) => ContourObject(schema, allowExtraFields: allowExtraFields);
