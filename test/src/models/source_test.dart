import 'package:ht_countries_client/ht_countries_client.dart';
import 'package:ht_sources_client/src/models/source.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Source Model', () {
    const testId = 'test-uuid-123';
    const testName = 'Test News Source';
    const testDescription = 'A source for testing purposes.';
    const testUrl = 'https://example.com/test';
    const testType = SourceType.specializedPublisher;
    const testLanguage = 'en';
    // Use a valid Country instance for testing
    final testCountry = Country(
      id: 'country-uuid-456',
      isoCode: 'XX',
      name: 'Testland',
      flagUrl: 'https://example.com/flag.png',
    );
    // Get the JSON representation for comparison
    final testHeadquartersJson = testCountry.toJson();

    late Source minimalSource;
    late Source fullSource;

    setUp(() {
      minimalSource = Source(name: testName);
      fullSource = Source(
        id: testId,
        name: testName,
        description: testDescription,
        url: testUrl,
        type: testType,
        language: testLanguage,
        headquarters: testCountry,
      );
    });

    group('Constructor', () {
      test('creates instance with only required name and generates ID', () {
        expect(minimalSource.name, testName);
        expect(minimalSource.id, isA<String>());
        expect(
          Uuid.isValidUUID(
            fromString: minimalSource.id,
            validationMode: ValidationMode.nonStrict,
          ),
          isTrue,
        );
        expect(minimalSource.description, isNull);
        expect(minimalSource.url, isNull);
        expect(minimalSource.type, isNull);
        expect(minimalSource.language, isNull);
        expect(minimalSource.headquarters, isNull);
      });

      test('creates instance with all fields including explicit id', () {
        expect(fullSource.id, testId);
        expect(fullSource.name, testName);
        expect(fullSource.description, testDescription);
        expect(fullSource.url, testUrl);
        expect(fullSource.type, testType);
        expect(fullSource.language, testLanguage);
        expect(fullSource.headquarters, testCountry);
      });
    });

    group('Equatable Props and Equality', () {
      test('props list contains all relevant fields', () {
        expect(
          fullSource.props,
          equals([
            testId,
            testName,
            testDescription,
            testUrl,
            testType,
            testLanguage,
            testCountry,
          ]),
        );
      });

      test('instances with same props are equal', () {
        final source1 = Source(
          id: testId,
          name: testName,
          description: testDescription,
          url: testUrl,
          type: testType,
          language: testLanguage,
          headquarters: testCountry,
        );
        final source2 = Source(
          id: testId,
          name: testName,
          description: testDescription,
          url: testUrl,
          type: testType,
          language: testLanguage,
          headquarters: testCountry,
        );
        expect(source1, equals(source2));
        expect(source1.hashCode, equals(source2.hashCode));
      });

      test('instances with different props are not equal', () {
        final source1 = Source(id: testId, name: testName);
        final source2 = Source(
          id: 'different-id', // Different ID
          name: testName,
        );
        final source3 = Source(
          id: testId,
          name: 'Different Name', // Different Name
        );
        expect(source1, isNot(equals(source2)));
        expect(source1.hashCode, isNot(equals(source2.hashCode)));
        expect(source1, isNot(equals(source3)));
        expect(source1.hashCode, isNot(equals(source3.hashCode)));
      });
    });

    group('JSON Serialization (toJson)', () {
      test('serializes minimal source correctly', () {
        final json = minimalSource.toJson();
        expect(json, isA<Map<String, dynamic>>());
        expect(json['id'], minimalSource.id); // ID is always present
        expect(json['name'], testName);
        expect(json.containsKey('description'), isFalse);
        expect(json.containsKey('url'), isFalse);
        expect(json.containsKey('type'), isFalse);
        expect(json.containsKey('language'), isFalse);
        expect(json.containsKey('headquarters'), isFalse);
      });

      test('serializes full source correctly', () {
        final json = fullSource.toJson();
        expect(json, isA<Map<String, dynamic>>());
        expect(json['id'], testId);
        expect(json['name'], testName);
        expect(json['description'], testDescription);
        expect(json['url'], testUrl);
        expect(json['type'], sourceTypeToJson(testType)); // Use helper
        expect(json['language'], testLanguage);
        expect(json['headquarters'], testHeadquartersJson);
      });

      test('does not include null optional fields in JSON', () {
        final sourceWithNulls = Source(id: testId, name: testName);
        final json = sourceWithNulls.toJson();
        expect(json.containsKey('description'), isFalse);
        expect(json.containsKey('url'), isFalse);
        expect(json.containsKey('type'), isFalse);
        expect(json.containsKey('language'), isFalse);
        expect(
          json.containsKey('headquarters'),
          isFalse,
        ); // Verify this specifically
      });
    });

    group('JSON Deserialization (fromJson)', () {
      test('deserializes minimal JSON correctly', () {
        final minimalJson = {'id': testId, 'name': testName};
        final source = Source.fromJson(minimalJson);
        expect(source.id, testId);
        expect(source.name, testName);
        expect(source.description, isNull);
        expect(source.url, isNull);
        expect(source.type, isNull);
        expect(source.language, isNull);
        expect(source.headquarters, isNull);
      });

      test('deserializes full JSON correctly', () {
        final fullJson = {
          'id': testId,
          'name': testName,
          'description': testDescription,
          'url': testUrl,
          'type': sourceTypeToJson(testType), // Use helper for consistency
          'language': testLanguage,
          'headquarters': testHeadquartersJson,
        };
        final source = Source.fromJson(fullJson);
        expect(source.id, testId);
        expect(source.name, testName);
        expect(source.description, testDescription);
        expect(source.url, testUrl);
        expect(source.type, testType);
        expect(source.language, testLanguage);
        expect(
          source.headquarters,
          equals(testCountry),
        ); // Use equals for Equatable
      });

      test('handles missing optional fields in JSON', () {
        final jsonWithMissing = {
          'id': testId,
          'name': testName,
          // description, url, type, language, headquarters are missing
        };
        final source = Source.fromJson(jsonWithMissing);
        expect(source.description, isNull);
        expect(source.url, isNull);
        expect(source.type, isNull);
        expect(source.language, isNull);
        expect(source.headquarters, isNull);
      });

      test('handles explicitly null optional fields in JSON', () {
        final jsonWithNulls = {
          'id': testId,
          'name': testName,
          'description': null,
          'url': null,
          'type': null,
          'language': null,
          'headquarters': null,
        };
        final source = Source.fromJson(jsonWithNulls);
        expect(source.description, isNull);
        expect(source.url, isNull);
        expect(source.type, isNull);
        expect(source.language, isNull);
        expect(source.headquarters, isNull);
      });

      test('handles unknown type string in JSON gracefully', () {
        final jsonWithUnknownType = {
          'id': testId,
          'name': testName,
          'type': 'some-unknown-type',
        };
        final source = Source.fromJson(jsonWithUnknownType);
        expect(source.type, isNull); // Should default to null
      });
    });

    group('copyWith Method', () {
      test('creates an identical copy with no arguments', () {
        final copy = fullSource.copyWith();
        expect(copy, equals(fullSource));
        expect(copy.hashCode, equals(fullSource.hashCode));
        // Ensure it's a new instance, not the same object reference
        expect(identical(copy, fullSource), isFalse);
      });

      test('updates individual fields correctly', () {
        const updatedId = 'new-id-456';
        const updatedName = 'Updated Source Name';
        const updatedDesc = 'New description.';
        const updatedUrl = 'https://new.example.com';
        const updatedType = SourceType.blog;
        const updatedLang = 'fr';
        final updatedCountry = Country(
          isoCode: 'YY',
          name: 'Newland',
          flagUrl: 'new.png',
          id: 'c-789',
        );

        expect(fullSource.copyWith(id: updatedId).id, updatedId);
        expect(fullSource.copyWith(name: updatedName).name, updatedName);
        expect(
          fullSource.copyWith(description: updatedDesc).description,
          updatedDesc,
        );
        expect(fullSource.copyWith(url: updatedUrl).url, updatedUrl);
        expect(fullSource.copyWith(type: updatedType).type, updatedType);
        expect(
          fullSource.copyWith(language: updatedLang).language,
          updatedLang,
        );
        expect(
          fullSource.copyWith(headquarters: updatedCountry).headquarters,
          updatedCountry,
        );
      });

      test('updates multiple fields simultaneously', () {
        const updatedName = 'Multi Update Source';
        const updatedType = SourceType.aggregator;
        final updatedCopy = fullSource.copyWith(
          name: updatedName,
          type: updatedType,
        );

        expect(updatedCopy.id, fullSource.id); // Unchanged
        expect(updatedCopy.name, updatedName); // Changed
        expect(updatedCopy.description, fullSource.description); // Unchanged
        expect(updatedCopy.url, fullSource.url); // Unchanged
        expect(updatedCopy.type, updatedType); // Changed
        expect(updatedCopy.language, fullSource.language); // Unchanged
        expect(updatedCopy.headquarters, fullSource.headquarters); // Unchanged
      });
    });

    // Test the helper functions directly using @visibleForTesting access
    group('Helper Functions (@visibleForTesting)', () {
      group('sourceTypeToJson', () {
        test('converts all SourceType enums to correct kebab-case strings', () {
          expect(sourceTypeToJson(SourceType.newsAgency), 'news-agency');
          expect(
            sourceTypeToJson(SourceType.localNewsOutlet),
            'local-news-outlet',
          );
          expect(
            sourceTypeToJson(SourceType.nationalNewsOutlet),
            'national-news-outlet',
          );
          expect(
            sourceTypeToJson(SourceType.internationalNewsOutlet),
            'international-news-outlet',
          );
          expect(
            sourceTypeToJson(SourceType.specializedPublisher),
            'specialized-publisher',
          );
          expect(sourceTypeToJson(SourceType.blog), 'blog');
          expect(
            sourceTypeToJson(SourceType.governmentSource),
            'government-source',
          );
          expect(sourceTypeToJson(SourceType.aggregator), 'aggregator');
          expect(sourceTypeToJson(SourceType.other), 'other');
        });

        test('returns null for null input', () {
          expect(sourceTypeToJson(null), isNull);
        });
      });

      group('sourceTypeFromJson', () {
        test(
          'converts all valid kebab-case strings to correct SourceType enums',
          () {
            expect(sourceTypeFromJson('news-agency'), SourceType.newsAgency);
            expect(
              sourceTypeFromJson('local-news-outlet'),
              SourceType.localNewsOutlet,
            );
            expect(
              sourceTypeFromJson('national-news-outlet'),
              SourceType.nationalNewsOutlet,
            );
            expect(
              sourceTypeFromJson('international-news-outlet'),
              SourceType.internationalNewsOutlet,
            );
            expect(
              sourceTypeFromJson('specialized-publisher'),
              SourceType.specializedPublisher,
            );
            expect(sourceTypeFromJson('blog'), SourceType.blog);
            expect(
              sourceTypeFromJson('government-source'),
              SourceType.governmentSource,
            );
            expect(sourceTypeFromJson('aggregator'), SourceType.aggregator);
            expect(sourceTypeFromJson('other'), SourceType.other);
          },
        );

        test('returns null for null input', () {
          expect(sourceTypeFromJson(null), isNull);
        });

        test('returns null for invalid/unknown string input', () {
          expect(sourceTypeFromJson(''), isNull);
          expect(sourceTypeFromJson('invalid-string'), isNull);
          expect(sourceTypeFromJson('NewsAgency'), isNull); // Case-sensitive
        });
      });
    });
  });
}
