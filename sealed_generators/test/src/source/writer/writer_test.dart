import 'package:sealed_generators/src/source/source.dart';
import 'package:sealed_generators/src/source/writer/writer.dart';
import 'package:sealed_generators/src/utils/string_utils.dart';
import 'package:test/test.dart';

import '../../../utils/code_utils.dart';
import '../../../utils/examples.dart';

void main() {
  group('class SourceWriter', () {
    test('initialization', () {
      final source = source1DataSafe;
      final writer = SourceWriter(source);

      expect(writer.source, source);
    });

    test('method topManifest', () {
      final source = source1DataSafe;
      final writer = SourceWriter(source);

      expect(
        writer.topManifest(),
        '@SealedManifest(_Weather)',
      );
    });

    group('method subFieldDeclaration', () {
      group('null-safe', () {
        final source = source1DataSafe;
        // void windy(double velocity, double? angle);
        final item = source.manifest.items[2];
        final field1 = item.fields[0];
        final field2 = item.fields[1];
        final writer = SourceWriter(source);

        test('non-nullable field', () {
          expect(
            writer.subFieldDeclaration(field1),
            'final double velocity;',
          );
        });

        test('nullable field', () {
          expect(
            writer.subFieldDeclaration(field2),
            'final double? angle;',
          );
        });
      });

      group('legacy', () {
        final source = source1DataLegacy;
        // void windy(double velocity, double? angle);
        final item = source.manifest.items[2];
        final field1 = item.fields[0];
        final field2 = item.fields[1];
        final writer = SourceWriter(source);

        test('non-nullable field', () {
          expect(
            writer.subFieldDeclaration(field1),
            'final double/*!*/ velocity;',
          );
        });

        test('nullable field', () {
          expect(
            writer.subFieldDeclaration(field2),
            'final double/*?*/ angle;',
          );
        });
      });
    });

    test('method subFieldDeclarations', () {
      final source = source1DataSafe;
      // void windy(double velocity, double? angle);
      final item = source.manifest.items[2];
      final writer = SourceWriter(source);

      expect(
        writer.subFieldDeclarations(item).tr(),
        stringContains([
          'final double velocity;',
          'final double? angle;',
        ]),
      );
    });

    group('method subConstructorDeclarationPart', () {
      group('null-safe', () {
        final source = source1DataSafe;
        // void windy(double velocity, double? angle);
        final item = source.manifest.items[2];
        final field1 = item.fields[0];
        final field2 = item.fields[1];
        final writer = SourceWriter(source);

        test('non-nullable field', () {
          expect(
            writer.subConstructorDeclarationPart(field1),
            'required this.velocity',
          );
        });

        test('nullable field', () {
          expect(
            writer.subConstructorDeclarationPart(field2),
            'required this.angle',
          );
        });
      });

      group('legacy', () {
        final source = source1DataLegacy;
        // void windy(double velocity, double? angle);
        final item = source.manifest.items[2];
        final field1 = item.fields[0];
        final field2 = item.fields[1];
        final writer = SourceWriter(source);

        test('non-nullable field', () {
          expect(
            writer.subConstructorDeclarationPart(field1),
            '@required this.velocity',
          );
        });

        test('nullable field', () {
          expect(
            writer.subConstructorDeclarationPart(field2),
            '@required this.angle',
          );
        });
      });
    });

    test('method subConstructorDeclaration', () {
      final source = source1DataSafe;
      // void sunny();
      final item1 = source.manifest.items[0];
      // void rainy(int rain);
      final item2 = source.manifest.items[1];
      // void windy(double velocity, double? angle);
      final item3 = source.manifest.items[2];
      final writer = SourceWriter(source);

      expect(
        writer.subConstructorDeclaration(item1).tr(),
        'WeatherSunny();',
      );
      expect(
        writer.subConstructorDeclaration(item2).tr(),
        'WeatherRainy({required this.rain});',
      );
      expect(
        writer.subConstructorDeclaration(item3).tr(),
        'WeatherWindy({required this.velocity, required this.angle,});',
      );
    });

    test('method subToStringPart', () {
      final source = source1DataLegacy;
      // void rainy(int rain);
      final item = source.manifest.items[1];
      final field = item.fields[0];
      final writer = SourceWriter(source);

      expect(
        writer.subToStringPart(field),
        r'rain: $rain',
      );
    });

    group('method subToString', () {
      test('null-safe', () {
        final source = source1DataSafe;
        // void sunny();
        final item1 = source.manifest.items[0];
        // void rainy(int rain);
        final item2 = source.manifest.items[1];
        // void windy(double velocity, double? angle);
        final item3 = source.manifest.items[2];
        final writer = SourceWriter(source);

        expect(
          writer.subToString(item1).tr(),
          '@override'
          r"String toString() => 'Weather.sunny()';",
        );
        expect(
          writer.subToString(item2).tr(),
          '@override'
          r"String toString() => 'Weather.rainy(rain: $rain)';",
        );
        expect(
          writer.subToString(item3).tr(),
          '@override'
          "String toString() => 'Weather.windy"
          r"(velocity: $velocity, angle: $angle)';",
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        // void rainy(int rain);
        final item2 = source.manifest.items[1];
        final writer = SourceWriter(source);

        expect(
          writer.subToString(item2).tr(),
          '@override'
          r"String/*!*/ toString() => 'Weather.rainy(rain: $rain)';",
        );
      });
    });

    group('method topDistinctEquality', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final writer = SourceWriter(source);

        expect(
          writer.topDistinctEquality().tr(),
          '@override'
          'bool operator ==(Object other) => false;',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final writer = SourceWriter(source);

        expect(
          writer.topDistinctEquality().tr(),
          '@override'
          'bool/*!*/ operator ==(Object/*?*/ other) => false;',
        );
      });
    });

    group('method topDistinctEquality', () {
      test('null-safe', () {
        final source = source1DataSafe;
        // void windy(double velocity, double? angle);
        final item3 = source.manifest.items[2];
        final writer = SourceWriter(source);

        expect(
          writer.subEquatableEquality(item3).tr(),
          '@override'
          'List<Object?> get props => [velocity, angle,];',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        // void windy(double velocity, double? angle);
        final item3 = source.manifest.items[2];
        final writer = SourceWriter(source);

        expect(
          writer.subEquatableEquality(item3).tr(),
          '@override'
          'List<Object/*?*/>/*!*/ get props => [velocity, angle,];',
        );
      });
    });

    group('method subCopyDeclarationPart', () {
      test('null-safe', () {
        final source = source1DataSafe;
        // void windy(double velocity, double? angle);
        final item3 = source.manifest.items[2];
        final field1 = item3.fields[0];
        final field2 = item3.fields[1];
        final writer = SourceWriter(source);

        expect(
          writer.subCopyDeclarationPart(field1),
          'double? velocity',
        );
        expect(
          writer.subCopyDeclarationPart(field2),
          'double? angle',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        // void windy(double velocity, double? angle);
        final item3 = source.manifest.items[2];
        final field1 = item3.fields[0];
        final field2 = item3.fields[1];
        final writer = SourceWriter(source);

        expect(
          writer.subCopyDeclarationPart(field1),
          'double/*?*/ velocity',
        );
        expect(
          writer.subCopyDeclarationPart(field2),
          'double/*?*/ angle',
        );
      });
    });

    test('method subCopyCalcPart', () {
      final source = source1DataSafe;
      // void windy(double velocity, double? angle);
      final item3 = source.manifest.items[2];
      final field1 = item3.fields[0];
      final field2 = item3.fields[1];
      final writer = SourceWriter(source);

      expect(
        writer.subCopyCalcPart(field1),
        'velocity: velocity ?? this.velocity',
      );
      expect(
        writer.subCopyCalcPart(field2),
        'angle: angle ?? this.angle',
      );
    });

    group('method subCopyDeclaration', () {
      test('null-safe', () {
        final source = source1DataSafe;
        // void sunny();
        final item1 = source.manifest.items[0];
        // void rainy(int rain);
        final item2 = source.manifest.items[1];
        final writer = SourceWriter(source);

        expect(
          writer.subCopyDeclaration(item1).tr(),
          '@factory'
          'WeatherSunny copy() =>'
          ' WeatherSunny();',
        );
        expect(
          writer.subCopyDeclaration(item2).tr(),
          '@factory'
          'WeatherRainy copy({int? rain}) =>'
          ' WeatherRainy(rain: rain ?? this.rain);',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        // void rainy(int rain);
        final item2 = source.manifest.items[1];
        final writer = SourceWriter(source);

        expect(
          writer.subCopyDeclaration(item2).tr(),
          '@factory'
          'WeatherRainy/*!*/ copy({int/*?*/ rain}) =>'
          ' WeatherRainy(rain: rain ?? this.rain);',
        );
      });
    });

    group('method subClass', () {
      test('equality data', () {
        final options = optionsDataSafe;
        final manifest = manifest1;
        final source = Source(options: options, manifest: manifest);
        // void rainy(int rain);
        final item2 = source.manifest.items[1];
        final writer = SourceWriter(source);

        expect(
          writer.subClass(item2).tr(),
          allOf(
            startsWith('class WeatherRainy extends Weather{'),
            endsWith('}'),
            stringContains([
              'WeatherRainy({required this.rain});',
              'final int rain;',
              'WeatherRainy copy(',
              'String toString(',
              'get props'
            ]),
          ),
        );
      });

      test('equality identity', () {
        final options = optionsIdentitySafe;
        final manifest = manifest1;
        final source = Source(options: options, manifest: manifest);
        // void rainy(int rain);
        final item2 = source.manifest.items[1];
        final writer = SourceWriter(source);

        expect(
          writer.subClass(item2).tr(),
          isNot(stringContains(['get props'])),
        );
      });

      test('equality distinct', () {
        final options = optionsDistinctSafe;
        final manifest = manifest1;
        final source = Source(options: options, manifest: manifest);
        // void rainy(int rain);
        final item2 = source.manifest.items[1];
        final writer = SourceWriter(source);

        expect(
          writer.subClass(item2).tr(),
          isNot(stringContains(['get props'])),
        );
      });
    });

    group('method topMethods', () {
      test('equality data', () {
        final source = source1DataSafe;
        final writer = SourceWriter(source);

        expect(
          writer.topMethods(),
          containsAll([
            ...writer.topBuilderWriter.topBuilderMethods(),
            ...writer.topCastWriter.topCastMethods(),
            ...writer.topMatchMethods(),
          ]),
        );
      });

      test('equality identity', () {
        final source = source1IdentityLegacy;
        final writer = SourceWriter(source);

        expect(
          writer.topMethods(),
          containsAll([
            ...writer.topBuilderWriter.topBuilderMethods(),
            ...writer.topCastWriter.topCastMethods(),
            ...writer.topMatchMethods(),
          ]),
        );
      });

      test('equality distinct', () {
        final source = source1DistinctLegacy;
        final writer = SourceWriter(source);

        expect(
          writer.topMethods(),
          containsAll([
            ...writer.topBuilderWriter.topBuilderMethods(),
            ...writer.topCastWriter.topCastMethods(),
            ...writer.topMatchMethods(),
            writer.topDistinctEquality(),
          ]),
        );
      });
    });

    group('method topClassStart', () {
      test('equality data', () {
        final source = source1DataSafe;
        final writer = SourceWriter(source);

        expect(
          writer.topClassStart(),
          '@SealedManifest(_Weather)\n'
          'abstract class Weather extends Equatable',
        );
      });

      test('equality identity', () {
        final source = source1IdentityLegacy;
        final writer = SourceWriter(source);

        expect(
          writer.topClassStart(),
          '@SealedManifest(_Weather)\n'
          'abstract class Weather',
        );
      });

      test('equality distinct', () {
        final source = source1DistinctLegacy;
        final writer = SourceWriter(source);

        expect(
          writer.topClassStart(),
          '@SealedManifest(_Weather)\n'
          'abstract class Weather',
        );
      });
    });

    test('method topClass', () {
      final source = source1DataSafe;
      final writer = SourceWriter(source);

      expect(
        writer.topClass(),
        stringContainsInOrder([
          writer.topClassStart(),
          '{',
          ...writer.topMethods(),
          '}',
        ]),
      );
    });

    test('method subClasses', () {
      final source = source1DataSafe;
      final manifest = source.manifest;
      final writer = SourceWriter(source);

      expect(
        writer.subClasses(),
        containsAllInOrder(
          manifest.items.map(writer.subClass).toList(),
        ),
      );
    });

    test('method classes', () {
      final source = source1DataSafe;
      final writer = SourceWriter(source);

      expect(
        writer.classes(),
        containsAllInOrder([
          writer.topClass(),
          ...writer.subClasses(),
        ]),
      );
    });

    test('method write', () {
      final source = source1DataSafe;
      final writer = SourceWriter(source);

      expect(
        writer.write(),
        writer.classes().joinMethods(),
      );
    });
    // end of source writer test group
  });
}