/// A Dart client interface for managing news sources.
library;

// Core Client Interface and Exceptions
export 'src/ht_sources_client.dart'
    show
        HtSourcesClient,
        SourceCreateFailure,
        SourceDeleteFailure,
        SourceFetchFailure,
        SourceNotFoundException,
        SourceUpdateFailure;

// Models
export 'src/models/source.dart' show Source;
