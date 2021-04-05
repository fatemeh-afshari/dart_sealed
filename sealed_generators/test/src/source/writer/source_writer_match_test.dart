import 'package:sealed_generators/src/source/writer/source_writer.dart';
import 'package:test/test.dart';

import '../../../utils/code_utils.dart';
import '../../../utils/examples.dart';

void main() {
  group('class SourceWriter match', () {
    group('method topMatchParam', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final writer = SourceWriter(source);

        expect(
          writer.topMatchParam,
          '<R extends Object?>',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final writer = SourceWriter(source);

        expect(
          writer.topMatchParam,
          '<R extends Object/*?*/>',
        );
      });
    });

    group('method topMatchGenericNNArg', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final manifest = source.manifest;
        // sunny
        final item1 = manifest.items[0];
        final writer = SourceWriter(source);

        expect(
          writer.topMatchGenericNNArg(item1),
          'required R Function(WeatherSunny sunny) sunny',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final manifest = source.manifest;
        // sunny
        final item1 = manifest.items[0];
        final writer = SourceWriter(source);

        expect(
          writer.topMatchGenericNNArg(item1),
          '@required R Function(WeatherSunny/*!*/ sunny)/*!*/ sunny',
        );
      });
    });

    group('method topMatchGenericNNArgOrElse', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final writer = SourceWriter(source);

        expect(
          writer.topMatchGenericNNArgOrElse(),
          'required R Function(Weather weather) orElse',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final writer = SourceWriter(source);

        expect(
          writer.topMatchGenericNNArgOrElse(),
          '@required R Function(Weather/*!*/ weather)/*!*/ orElse',
        );
      });
    });

    group('method topMatchGenericNArg', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final manifest = source.manifest;
        // sunny
        final item1 = manifest.items[0];
        final writer = SourceWriter(source);

        expect(
          writer.topMatchGenericNArg(item1),
          'R Function(WeatherSunny sunny)? sunny',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final manifest = source.manifest;
        // sunny
        final item1 = manifest.items[0];
        final writer = SourceWriter(source);

        expect(
          writer.topMatchGenericNArg(item1),
          'R Function(WeatherSunny/*!*/ sunny)/*?*/ sunny',
        );
      });
    });

    group('method topMatchGenericReturn', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final writer = SourceWriter(source);

        expect(
          writer.topMatchParam,
          '<R extends Object?>',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final writer = SourceWriter(source);

        expect(
          writer.topMatchParam,
          '<R extends Object/*?*/>',
        );
      });
    });

    group('method topMatchVoidNNArg', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final manifest = source.manifest;
        // sunny
        final item1 = manifest.items[0];
        final writer = SourceWriter(source);

        expect(
          writer.topMatchVoidNNArg(item1),
          'required void Function(WeatherSunny sunny) sunny',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final manifest = source.manifest;
        // sunny
        final item1 = manifest.items[0];
        final writer = SourceWriter(source);

        expect(
          writer.topMatchVoidNNArg(item1),
          '@required void Function(WeatherSunny/*!*/ sunny)/*!*/ sunny',
        );
      });
    });

    group('method topMatchVoidNNArgOrElse', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final writer = SourceWriter(source);

        expect(
          writer.topMatchVoidNNArgOrElse(),
          'required void Function(Weather weather) orElse',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final writer = SourceWriter(source);

        expect(
          writer.topMatchVoidNNArgOrElse(),
          '@required void Function(Weather/*!*/ weather)/*!*/ orElse',
        );
      });
    });

    group('method topMatchVoidNArg', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final manifest = source.manifest;
        // sunny
        final item1 = manifest.items[0];
        final writer = SourceWriter(source);

        expect(
          writer.topMatchVoidNArg(item1),
          'void Function(WeatherSunny sunny)? sunny',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final manifest = source.manifest;
        // sunny
        final item1 = manifest.items[0];
        final writer = SourceWriter(source);

        expect(
          writer.topMatchVoidNArg(item1),
          'void Function(WeatherSunny/*!*/ sunny)/*?*/ sunny',
        );
      });
    });

    test('method topMatchAssert', () {
      final source = source1DataLegacy;
      final manifest = source.manifest;
      // sunny
      final item1 = manifest.items[0];
      final writer = SourceWriter(source);

      expect(
        writer.topMatchAssert(item1),
        'assert(sunny != null);',
      );
    });

    test('method topMatchAssertOrElse', () {
      final source = source1DataLegacy;
      final writer = SourceWriter(source);

      expect(
        writer.topMatchAssertOrElse(),
        'assert(orElse != null);',
      );
    });

    test('method topMatchAsserts', () {
      final source = source1DataLegacy;
      final writer = SourceWriter(source);

      expect(
        writer.topMatchAsserts().tr(),
        stringContains([
          'assert(sunny != null);',
          'rainy',
          'windy',
        ]),
      );
    });

    test('method throwAssertion', () {
      final source = source1DataSafe;
      final writer = SourceWriter(source);

      expect(
        writer.throwAssertion(),
        'throw AssertionError();',
      );
    });

    test('method throwingElse', () {
      final source = source1DataSafe;
      final writer = SourceWriter(source);
      final e = writer.throwingElse();

      expect(e.code, 'throw AssertionError();');
    });

    test('method topMatchWhenIfs', () {
      final source = source1DataSafe;
      final manifest = source.manifest;
      // sunny
      final item1 = manifest.items[0];
      final writer = SourceWriter(source);
      final i = writer.topMatchWhenIfs(item1);

      expect(i.condition, 'weather is WeatherSunny');
      expect(i.code, 'return sunny(weather);');
    });

    test('method topMatchWhenBody', () {
      final source = source1DataSafe;
      final writer = SourceWriter(source);

      expect(
        writer.topMatchWhenBody(),
        'final weather = this;\n'
        'if (weather is WeatherSunny) {return sunny(weather);}\n'
        'else if (weather is WeatherRainy) {return rainy(weather);}\n'
        'else if (weather is WeatherWindy) {return windy(weather);}\n'
        'else {throw AssertionError();}',
      );
    });

    test('method topMatchWhenStart', () {
      final source = source1DataSafe;
      final writer = SourceWriter(source);

      expect(
        writer.topMatchWhenStart(),
        'R when<R extends Object?>({'
        'required R Function(WeatherSunny sunny) sunny,'
        ' required R Function(WeatherRainy rainy) rainy,'
        ' required R Function(WeatherWindy windy) windy,'
        '})',
      );
    });

    group('method topMatchWhen', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final writer = SourceWriter(source);

        expect(
          writer.topMatchWhen(),
          stringContainsInOrder([
            (writer.topMatchWhenStart()),
            '{',
            (writer.topMatchWhenBody()),
            '}',
          ]),
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final writer = SourceWriter(source);

        expect(
          writer.topMatchWhen(),
          stringContainsInOrder([
            (writer.topMatchWhenStart()),
            '{',
            (writer.topMatchAsserts()),
            (writer.topMatchWhenBody()),
            '}',
          ]),
        );
      });
    });

    test('method topMatchWhenOrElseIfs', () {
      final source = source1DataSafe;
      final manifest = source.manifest;
      // sunny
      final item1 = manifest.items[0];
      final writer = SourceWriter(source);
      final i = writer.topMatchWhenOrElseIfs(item1);

      expect(i.condition, 'weather is WeatherSunny');
      expect(i.code, 'return (sunny ?? orElse)(weather);');
    });

    test('method topMatchWhenOrElseBody', () {
      final source = source1DataSafe;
      final writer = SourceWriter(source);

      expect(
        writer.topMatchWhenOrElseBody(),
        'final weather = this;\n'
        'if (weather is WeatherSunny) {return (sunny ?? orElse)(weather);}\n'
        'else if (weather is WeatherRainy) {return (rainy ?? orElse)(weather);}\n'
        'else if (weather is WeatherWindy) {return (windy ?? orElse)(weather);}\n'
        'else {throw AssertionError();}',
      );
    });

    test('method topMatchWhenOrElseStart', () {
      final source = source1DataSafe;
      final writer = SourceWriter(source);

      expect(
        writer.topMatchWhenOrElseStart(),
        'R whenOrElse<R extends Object?>({'
        'R Function(WeatherSunny sunny)? sunny,'
        ' R Function(WeatherRainy rainy)? rainy,'
        ' R Function(WeatherWindy windy)? windy,'
        ' required R Function(Weather weather) orElse,'
        '})',
      );
    });

    group('method topMatchWhenOrElse', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final writer = SourceWriter(source);

        expect(
          writer.topMatchWhenOrElse(),
          stringContainsInOrder([
            (writer.topMatchWhenOrElseStart()),
            '{',
            (writer.topMatchWhenOrElseBody()),
            '}',
          ]),
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final writer = SourceWriter(source);

        expect(
          writer.topMatchWhenOrElse(),
          stringContainsInOrder([
            (writer.topMatchWhenOrElseStart()),
            '{',
            (writer.topMatchAssertOrElse()),
            (writer.topMatchWhenOrElseBody()),
            '}',
          ]),
        );
      });
    });
    // end of source writer match test group
  });
}