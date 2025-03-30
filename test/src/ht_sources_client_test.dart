//
// ignore_for_file: prefer_const_constructors
import 'package:ht_sources_client/src/ht_sources_client.dart';
import 'package:test/test.dart';

void main() {
  group('HtSourcesClient Exceptions', () {
    test('SourceFetchFailure toString returns correct message', () {
      expect(
        SourceFetchFailure().toString(),
        equals('SourceFetchFailure: Failed to fetch sources.'),
      );
      expect(
        SourceFetchFailure('Custom message').toString(),
        equals('SourceFetchFailure: Custom message'),
      );
    });

    test('SourceNotFoundException toString returns correct message', () {
      expect(
        SourceNotFoundException().toString(),
        equals('SourceNotFoundException: Source not found.'),
      );
      expect(
        SourceNotFoundException('Custom message').toString(),
        equals('SourceNotFoundException: Custom message'),
      );
    });

    test('SourceCreateFailure toString returns correct message', () {
      expect(
        SourceCreateFailure().toString(),
        equals('SourceCreateFailure: Failed to create source.'),
      );
      expect(
        SourceCreateFailure('Custom message').toString(),
        equals('SourceCreateFailure: Custom message'),
      );
    });

    test('SourceUpdateFailure toString returns correct message', () {
      expect(
        SourceUpdateFailure().toString(),
        equals('SourceUpdateFailure: Failed to update source.'),
      );
      expect(
        SourceUpdateFailure('Custom message').toString(),
        equals('SourceUpdateFailure: Custom message'),
      );
    });

    test('SourceDeleteFailure toString returns correct message', () {
      expect(
        SourceDeleteFailure().toString(),
        equals('SourceDeleteFailure: Failed to delete source.'),
      );
      expect(
        SourceDeleteFailure('Custom message').toString(),
        equals('SourceDeleteFailure: Custom message'),
      );
    });
  });
}
