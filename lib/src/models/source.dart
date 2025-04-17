import 'package:equatable/equatable.dart';
import 'package:ht_countries_client/ht_countries_client.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

/// Helper function to convert SourceType enum to kebab-case string
@visibleForTesting
String? sourceTypeToJson(SourceType? type) {
  if (type == null) return null;
  switch (type) {
    case SourceType.newsAgency:
      return 'news-agency';
    case SourceType.localNewsOutlet:
      return 'local-news-outlet';
    case SourceType.nationalNewsOutlet:
      return 'national-news-outlet';
    case SourceType.internationalNewsOutlet:
      return 'international-news-outlet';
    case SourceType.specializedPublisher:
      return 'specialized-publisher';
    case SourceType.blog:
      return 'blog';
    case SourceType.governmentSource:
      return 'government-source';
    case SourceType.aggregator:
      return 'aggregator';
    case SourceType.other:
      return 'other';
  }
}

/// Helper function to convert kebab-case string to SourceType enum
@visibleForTesting
SourceType? sourceTypeFromJson(String? typeString) {
  if (typeString == null) return null;
  switch (typeString) {
    case 'news-agency':
      return SourceType.newsAgency;
    case 'local-news-outlet':
      return SourceType.localNewsOutlet;
    case 'national-news-outlet':
      return SourceType.nationalNewsOutlet;
    case 'international-news-outlet':
      return SourceType.internationalNewsOutlet;
    case 'specialized-publisher':
      return SourceType.specializedPublisher;
    case 'blog':
      return SourceType.blog;
    case 'government-source':
      return SourceType.governmentSource;
    case 'aggregator':
      return SourceType.aggregator;
    case 'other':
      return SourceType.other;
    default:
      // Handle unknown types if necessary, or return null/default
      return null;
  }
}

/// Enum representing the type of news source.
enum SourceType {
  /// A global news agency
  /// (e.g., Reuters, Associated Press, Agence France-Presse).
  newsAgency,

  /// A news outlet focused on a specific local area
  /// (e.g., San Francisco Chronicle, Manchester Evening News).
  localNewsOutlet,

  /// A news outlet focused on a specific country
  /// (e.g., BBC News (UK), The New York Times (US)).
  nationalNewsOutlet,

  /// A news outlet with a broad international focus
  /// (e.g., Al Jazeera English, CNN International).
  internationalNewsOutlet,

  /// A publisher focused on a specific topic
  /// (e.g., TechCrunch (technology), ESPN (sports), Nature (science)).
  specializedPublisher,

  /// A blog or personal publication
  /// (e.g., Stratechery by Ben Thompson).
  blog,

  /// An official government source
  /// (e.g., WhiteHouse.gov, gov.uk).
  governmentSource,

  /// A service that aggregates news from other sources
  /// (e.g., Google News, Apple News).
  aggregator,

  /// Any other type of source not covered above
  /// (e.g., academic journals, company press releases).
  other,
}

/// {@template source}
/// Source model
///
/// Represents a news source.
/// {@endtemplate}
class Source extends Equatable {
  /// {@macro source}
  Source({
    required this.name,
    this.description,
    this.url,
    this.type,
    this.language,
    this.headquarters,
    String? id,
  }) : id = id ?? const Uuid().v4();

  /// Factory method to create a [Source] instance from a JSON map.
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      url: json['url'] as String?,
      type: sourceTypeFromJson(json['type'] as String?),
      language: json['language'] as String?,
      headquarters:
          json['headquarters'] == null
              ? null
              : Country.fromJson(json['headquarters'] as Map<String, dynamic>),
    );
  }

  /// Unique identifier for the source.
  final String id;

  /// The name of the source.
  /// This is required and should not be null.
  final String name;

  /// A description of the source.
  final String? description;

  /// The URL of the source's homepage.
  final String? url;

  /// The type of the source (e.g., newsAgency, blog).
  final SourceType? type;

  /// The language code of the source (e.g., 'en', 'fr').
  final String? language;

  /// The country where the source is headquartered.
  final Country? headquarters;

  /// Converts this [Source] instance to a JSON map.
  Map<String, dynamic> toJson() {
    // Start with required fields
    final json = <String, dynamic>{'id': id, 'name': name};

    // Add optional fields only if they are not null
    if (description != null) {
      json['description'] = description;
    }
    if (url != null) {
      json['url'] = url;
    }
    if (type != null) {
      json['type'] = sourceTypeToJson(type);
    }
    if (language != null) {
      json['language'] = language;
    }
    if (headquarters != null) {
      // Assumes Country has a toJson method (likely from json_serializable)
      json['headquarters'] = headquarters!.toJson();
    }

    return json;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    url,
    type,
    language,
    headquarters,
  ];

  /// Creates a new [Source] with updated properties.
  /// Use this to modify a [Source] without changing the original instance.
  Source copyWith({
    String? id,
    String? name,
    String? description,
    String? url,
    SourceType? type,
    String? language,
    Country? headquarters,
  }) {
    return Source(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      type: type ?? this.type,
      language: language ?? this.language,
      headquarters: headquarters ?? this.headquarters,
    );
  }
}
