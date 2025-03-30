# ht_sources_client

A Dart client interface for managing news sources.

This package provides an abstract interface (`HtSourcesClient`) and data models (`Source`) for interacting with a news source backend. It defines the contract but does not include a concrete implementation.

## Installation

Since this package is not published on pub.dev (`publish_to: none`), add it as a Git dependency in your `pubspec.yaml`:

```yaml
dependencies:
  ht_sources_client:
    git:
      url: https://github.com/headlines-toolkit/ht-sources-client.git
      # Optional: specify a branch, tag, or commit hash
      # ref: main
```

Then run `flutter pub get`.

## Usage

Import the library:

```dart
import 'package:ht_sources_client/ht_sources_client.dart';
```

You need to use or create a concrete implementation of `HtSourcesClient` that handles the actual data fetching (e.g., from an API, local storage, etc.).

Example using a hypothetical `MySourcesClient` implementation:

```dart
// Assume MySourcesClient implements HtSourcesClient
final HtSourcesClient sourcesClient = MySourcesClient();

Future<void> fetchAndPrintSources() async {
  try {
    final List<Source> sources = await sourcesClient.getSources();
    if (sources.isEmpty) {
      print('No sources found.');
    } else {
      print('Fetched ${sources.length} sources:');
      for (final source in sources) {
        print('- ${source.name} (${source.id})');
      }
    }
  } on SourceFetchFailure catch (e) {
    print('Error fetching sources: $e');
  } catch (e) {
    print('An unexpected error occurred: $e');
  }
}

Future<void> main() async {
  await fetchAndPrintSources();
}

```

This package defines:
*   `HtSourcesClient`: The abstract class (interface) for CRUD operations.
*   `Source`: The data model for a news source.
*   Custom Exceptions (`SourceFetchFailure`, `SourceNotFoundException`, etc.) for error handling.

## License

This software is licensed under the [PolyForm Free Trial License 1.0.0](LICENSE). Please review the terms before use.
