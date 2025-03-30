import 'package:ht_sources_client/src/models/source.dart';

/// {@template source_fetch_failure}
/// Exception thrown when fetching sources fails.
/// {@endtemplate}
class SourceFetchFailure implements Exception {
  /// {@macro source_fetch_failure}
  const SourceFetchFailure([this.message = 'Failed to fetch sources.']);

  /// The error message.
  final String message;

  @override
  String toString() => 'SourceFetchFailure: $message';
}

/// {@template source_not_found_exception}
/// Exception thrown when a specific source is not found.
/// {@endtemplate}
class SourceNotFoundException implements Exception {
  /// {@macro source_not_found_exception}
  const SourceNotFoundException([this.message = 'Source not found.']);

  /// The error message.
  final String message;

  @override
  String toString() => 'SourceNotFoundException: $message';
}

/// {@template source_create_failure}
/// Exception thrown when creating a source fails.
/// {@endtemplate}
class SourceCreateFailure implements Exception {
  /// {@macro source_create_failure}
  const SourceCreateFailure([this.message = 'Failed to create source.']);

  /// The error message.
  final String message;

  @override
  String toString() => 'SourceCreateFailure: $message';
}

/// {@template source_update_failure}
/// Exception thrown when updating a source fails.
/// {@endtemplate}
class SourceUpdateFailure implements Exception {
  /// {@macro source_update_failure}
  const SourceUpdateFailure([this.message = 'Failed to update source.']);

  /// The error message.
  final String message;

  @override
  String toString() => 'SourceUpdateFailure: $message';
}

/// {@template source_delete_failure}
/// Exception thrown when deleting a source fails.
/// {@endtemplate}
class SourceDeleteFailure implements Exception {
  /// {@macro source_delete_failure}
  const SourceDeleteFailure([this.message = 'Failed to delete source.']);

  /// The error message.
  final String message;

  @override
  String toString() => 'SourceDeleteFailure: $message';
}


/// {@template ht_sources_client}
/// An abstract interface for a client that manages news sources.
///
/// This defines the contract for fetching, creating, updating,
/// and deleting [Source] objects. Implementations of this class
/// will handle the actual data retrieval and manipulation (e.g., from an API,
/// local database, etc.).
/// {@endtemplate}
abstract class HtSourcesClient {
  /// {@macro ht_sources_client}
  const HtSourcesClient();

  /// Creates a new news source.
  ///
  /// Takes a [Source] object (without an ID, typically) and persists it.
  /// Returns the created [Source], usually with a server-assigned ID.
  ///
  /// Throws a [SourceCreateFailure] if the operation fails.
  Future<Source> createSource({required Source source});

  /// Retrieves a specific news source by its unique [id].
  ///
  /// Throws a [SourceNotFoundException] if no source with the given [id] exists.
  /// Throws a [SourceFetchFailure] for other fetch-related errors.
  Future<Source> getSource({required String id});

  /// Retrieves a list of all available news sources.
  ///
  /// Returns an empty list if no sources are available.
  /// Throws a [SourceFetchFailure] if the operation fails.
  Future<List<Source>> getSources();

  /// Updates an existing news source.
  ///
  /// Takes a [Source] object with an existing [id] and updated fields.
  /// Returns the updated [Source].
  ///
  /// Throws a [SourceNotFoundException] if the source to update doesn't exist.
  /// Throws a [SourceUpdateFailure] for other update-related errors.
  Future<Source> updateSource({required Source source});

  /// Deletes a news source by its unique [id].
  ///
  /// Throws a [SourceNotFoundException] if the source to delete doesn't exist.
  /// Throws a [SourceDeleteFailure] for other delete-related errors.
  Future<void> deleteSource({required String id});
}
