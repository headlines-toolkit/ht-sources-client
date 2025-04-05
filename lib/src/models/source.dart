import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'source.g.dart';

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
    this.category,
    this.language,
    this.country,
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

  /// The category the source belongs to (e.g., technology, sports).
  final String? category;

  /// The language code of the source (e.g., 'en', 'fr').
  final String? language;

  /// The country code of the source (e.g., 'us', 'gb').
  final String? country;

  /// Converts this [Source] instance to a JSON map.
  Map<String, dynamic> toJson() => _$SourceToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    url,
    category,
    language,
    country,
  ];

  /// Creates a new [Source] with updated properties.
  /// Use this to modify a [Source] without changing the original instance.
  Source copyWith({
    String? id,
    String? name,
    String? description,
    String? url,
    String? category,
    String? language,
    String? country,
  }) {
    return Source(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      category: category ?? this.category,
      language: language ?? this.language,
      country: country ?? this.country,
    );
  }
}
