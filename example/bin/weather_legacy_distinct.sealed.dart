// GENERATED CODE - DO NOT MODIFY BY HAND

// @dart=2.9
part of 'weather_legacy_distinct.dart';

// **************************************************************************
// Generator: sealed_generators
// **************************************************************************

// **************************************************************************
// backward generated code:
// language level: legacy
@Sealed(equality: SealedEquality.distinct)
// ignore: unused_element
abstract class _Weather$ {
  void sunny();

  void rainy(int /*?*/ rain);

  void windy(
    double /*?*/ velocity,
    double /*?*/ angle,
  );
}
// **************************************************************************

@SealedManifest(_Weather)
abstract class Weather {
  static WeatherSunny sunny() => WeatherSunny();

  static WeatherRainy rainy() => WeatherRainy();

  static WeatherWindy windy() => WeatherWindy();

  bool isSunny() => this is WeatherSunny;

  bool isRainy() => this is WeatherRainy;

  bool isWindy() => this is WeatherWindy;

  WeatherSunny /*!*/ asSunny() => this as WeatherSunny;

  WeatherRainy /*!*/ asRainy() => this as WeatherRainy;

  WeatherWindy /*!*/ asWindy() => this as WeatherWindy;

  WeatherSunny /*?*/ asSunnyOrNull() =>
      this is WeatherSunny ? this as WeatherSunny : null;

  WeatherRainy /*?*/ asRainyOrNull() =>
      this is WeatherRainy ? this as WeatherRainy : null;

  WeatherWindy /*?*/ asWindyOrNull() =>
      this is WeatherWindy ? this as WeatherWindy : null;
}

class WeatherSunny extends Weather {}

class WeatherRainy extends Weather {}

class WeatherWindy extends Weather {}
