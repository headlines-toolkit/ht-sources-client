import 'package:ht_sources_client/src/models/source.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Source Model', () {
    const uuid = Uuid();
    final testId = uuid.v4();
    const testName = 'Test Source';
    const testDescription = 'A source for testing purposes';
    const testUrl = 'https://example.com/source';
    const testCategory = 'testing';
    const testLanguage = 'en';
    const testCountry = 'us';

    final sourceJson = {
      'id': testId,
      'name': testName,
      'description': testDescription,
      'url': testUrl,
      'category': testCategory,
      'language': testLanguage,
      'country': testCountry,
    };

    Source createSubject({
      String? id,
      String name = testName,
      String? description = testDescription,
      String? url = testUrl,
      String? category = testCategory,
      String? language = testLanguage,
      String? country = testCountry,
    }) {
      return Source(
        id: id,
        name: name,
        description: description,
        url: url,
        category: category,
        language: language,
        country: country,
      );
    }

    test('constructor assigns default id when not provided', () {
      final source = createSubject();
      expect(source.id, isA<String>());
      expect(Uuid.isValidUUID(fromString: source.id), isTrue);
    });

    test('constructor assigns provided id', () {
      final source = createSubject(id: testId);
      expect(source.id, equals(testId));
    });

    test('supports value equality', () {
      final source1 = createSubject(id: testId);
      final source2 = createSubject(id: testId);
      expect(source1, equals(source2));
    });

    test('props are correct', () {
      final source = createSubject(id: testId);
      expect(
        source.props,
        equals([
          testId,
          testName,
          testDescription,
          testUrl,
          testCategory,
          testLanguage,
          testCountry,
        ]),
      );
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(Source.fromJson(sourceJson), equals(createSubject(id: testId)));
      });

      test('handles missing optional fields', () {
        final minimalJson = {'id': testId, 'name': testName};
        expect(
          Source.fromJson(minimalJson),
          equals(Source(id: testId, name: testName)),
        );
      });
    });

    group('toJson', () {
      test('works correctly', () {
        expect(createSubject(id: testId).toJson(), equals(sourceJson));
      });

      test('handles null optional fields', () {
        final source = Source(id: testId, name: testName);
        final expectedJson = {
          'id': testId,
          'name': testName,
          'description': null,
          'url': null,
          'category': null,
          'language': null,
          'country': null,
        };
        expect(source.toJson(), equals(expectedJson));
      });
    });

    group('copyWith', () {
      test('returns same object when no properties are passed', () {
        final source = createSubject(id: testId);
        expect(source.copyWith(), equals(source));
      });

      test('returns object with updated properties', () {
        final source = createSubject(id: testId);
        final updatedSource = source.copyWith(
          name: 'Updated Name',
          country: 'ca',
        );

        final expectedSource = Source(
          id: testId,
          name: 'Updated Name',
          description: testDescription, // Should keep original value
          url: testUrl,
          category: testCategory,
          language: testLanguage,
          country: 'ca', // Updated
        );

        expect(updatedSource, equals(expectedSource));
        // Ensure original is unchanged
        expect(source.name, equals(testName));
        expect(source.description, equals(testDescription));
        expect(source.country, equals(testCountry));
      });
    });
  });
}
