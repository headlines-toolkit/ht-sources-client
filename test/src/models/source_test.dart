import 'package:ht_countries_client/ht_countries_client.dart';
import 'package:ht_sources_client/src/models/source.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  // Mock Country data for testing
  final testHeadquartersCountry = Country(
    isoCode: 'US',
    name: 'United States',
    flagUrl: 'http://example.com/us-flag.png',
    id: 'country-uuid-123',
  );

  final testHeadquartersJson = {
    'id': 'country-uuid-123',
    'iso_code': 'US',
    'name': 'United States',
    'flag_url': 'http://example.com/us-flag.png',
  };

  group('Source Model', () {
    const uuid = Uuid();
    final testId = uuid.v4();
    const testName = 'Test Source';
    const testDescription = 'A source for testing purposes';
    const testUrl = 'https://example.com/source';
    const testType = SourceType.nationalNewsOutlet;
    const testTypeString = 'national-news-outlet'; // kebab-case for JSON
    const testLanguage = 'en';

    final testHeadquarters = testHeadquartersCountry;

    final sourceJson = {
      'id': testId,
      'name': testName,
      'description': testDescription,
      'url': testUrl,
      'type': testTypeString,
      'language': testLanguage,

      'headquarters': testHeadquartersJson,
    };

    Source createSubject({
      String? id,
      String name = testName,
      String? description = testDescription,
      String? url = testUrl,
      SourceType? type = testType,
      String? language = testLanguage,

      Country? headquarters, // Remove default value here
    }) {
      return Source(
        id: id ?? uuid.v4(), // Ensure ID is always present for tests
        name: name,
        description: description,
        url: url,
        type: type,
        language: language,

        headquarters:
            headquarters ?? testHeadquarters, // Assign default here if null
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
          testType,
          testLanguage,

          testHeadquarters,
        ]),
      );
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(Source.fromJson(sourceJson), equals(createSubject(id: testId)));
      });

      test('handles missing optional fields', () {
        final minimalJson = {'id': testId, 'name': testName};
        // Expect default values (null) for optional fields
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
          'type': null, // Enum to null directly
          'language': null,

          'headquarters': null, // Object to null
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
        final newHeadquarters = Country(
          isoCode: 'CA',
          name: 'Canada',
          flagUrl: 'http://example.com/ca-flag.png',
          id: 'country-uuid-456',
        );
        final updatedSource = source.copyWith(
          name: 'Updated Name',
          type: SourceType.localNewsOutlet,
          headquarters: newHeadquarters,
        );

        final expectedSource = Source(
          id: testId,
          name: 'Updated Name',
          description: testDescription,
          url: testUrl,
          type: SourceType.localNewsOutlet,
          language: testLanguage,

          headquarters: newHeadquarters,
        );

        expect(updatedSource, equals(expectedSource));
        // Ensure original is unchanged
        expect(source.name, equals(testName));
        expect(source.type, equals(testType));
        expect(source.headquarters, equals(testHeadquarters));
      });
    });
  });
}
