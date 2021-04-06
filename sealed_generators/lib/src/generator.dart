import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:sealed_annotations/sealed_annotations.dart';
import 'package:sealed_generators/src/source/reader/source_reader.dart';
import 'package:sealed_generators/src/source/writer/compat/compat_writer.dart';
import 'package:sealed_generators/src/source/writer/doc/doc_writer.dart';
import 'package:sealed_generators/src/source/writer/source_writer.dart';
import 'package:source_gen/source_gen.dart';

class SealedGenerator extends GeneratorForAnnotation<Sealed> {
  const SealedGenerator();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final reader = SourceReader();
    final source = reader.read(element, annotation);
    final compatWriter = CompatWriter(source);
    final docWriter = DocWriter(source);
    final writer = SourceWriter(source);

    final s = StringBuffer();
    s.writeln(compatWriter.write());
    s.writeln(docWriter.write());
    s.writeln(writer.write());
    return s.toString();
  }

  @override
  String toString() => 'sealed_generators';
}
