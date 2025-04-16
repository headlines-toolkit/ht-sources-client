import 'package:equatable/equatable.dart';
import 'package:ht_countries_client/ht_countries_client.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'source.g.dart';

/// Enum representing the type of news source.
@JsonEnum(fieldRename: FieldRename.kebab)
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
@JsonSerializable()
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
  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

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
  @JsonKey(name: 'headquarters')
  final Country? headquarters;

  /// Converts this [Source] instance to a JSON map.
  Map<String, dynamic> toJson() => _$SourceToJson(this);

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
