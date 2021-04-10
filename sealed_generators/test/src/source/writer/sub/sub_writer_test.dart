import 'package:sealed_generators/src/source/source.dart';
import 'package:sealed_generators/src/source/writer/sub/sub_writer.dart';
import 'package:test/test.dart';

import '../../../../utils/code_utils.dart';
import '../../../../utils/examples.dart';

void main() {
  group('class SubWriter', () {
    test('initialization', () {
      final source = source1DataSafe;
      final writer = SubWriter(source);

      expect(writer.source, source);
    });

    test('method hasNullable', () {
      final source = source1DataSafe;
      // void sunny();
      final manifest = source.manifest;
      final item1 = manifest.items[0];
      // void rainy(int rain);
      final item2 = manifest.items[1];
      // void windy(double velocity, double? angle);
      final item3 = manifest.items[2];
      final writer = SubWriter(source);

      expect(writer.hasNullable(item1), false);
      expect(writer.hasNullable(item2), false);
      expect(writer.hasNullable(item3), true);
    });

    group('method subFieldDeclaration', () {
      group('null-safe', () {
        final source = source1DataSafe;
        // void windy(double velocity, double? angle);
        final item = source.manifest.items[2];
        final field1 = item.fields[0];
        final field2 = item.fields[1];
        final writer = SubWriter(source);

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
        final writer = SubWriter(source);

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
      final writer = SubWriter(source);

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
        final writer = SubWriter(source);

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
        final writer = SubWriter(source);

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
      final writer = SubWriter(source);

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
      final writer = SubWriter(source);

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
        final writer = SubWriter(source);

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
        final writer = SubWriter(source);

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
        // void windy(double velocity, double? angle);
        final item3 = source.manifest.items[2];
        final writer = SubWriter(source);

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
        final writer = SubWriter(source);

        expect(
          writer.subEquatableEquality(item3).tr(),
          '@override'
          'List<Object/*?*/>/*!*/ get props => [velocity, angle,];',
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
        final writer = SubWriter(source);

        expect(
          writer.subClass(item2).tr(),
          allOf(
            startsWith('class WeatherRainy extends Weather'),
            endsWith('}'),
            stringContainsInOrder([
              '{',
              'WeatherRainy({required this.rain});',
              'final int rain;',
              'WeatherRainy copy(',
              'String toString(',
              'get props'
            ]),
          ),
        );
      });

      test('equality data with nullable', () {
        final options = optionsDataSafe;
        final manifest = manifest1;
        final source = Source(options: options, manifest: manifest);
        // void windy(double velocity, double? angle);
        final item3 = source.manifest.items[2];
        final writer = SubWriter(source);

        expect(
          writer.subClass(item3).tr(),
          isNot(stringContainsInOrder(['copy('])),
        );
      });

      test('equality identity', () {
        final options = optionsIdentitySafe;
        final manifest = manifest1;
        final source = Source(options: options, manifest: manifest);
        // void rainy(int rain);
        final item2 = source.manifest.items[1];
        final writer = SubWriter(source);

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
        final writer = SubWriter(source);

        expect(
          writer.subClass(item2).tr(),
          isNot(stringContains(['get props'])),
        );
      });
    });

    test('method subClasses', () {
      final source = source1DataSafe;
      final manifest = source.manifest;
      final writer = SubWriter(source);

      expect(
        writer.subClasses(),
        containsAllInOrder(
          manifest.items.map(writer.subClass).toList(),
        ),
      );
    });
    // end of group SubWriter
  });
}