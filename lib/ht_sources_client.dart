/// A Dart client interface for managing news sources.
library ht_sources_client;

// Core Client Interface and Exceptions
export 'src/ht_sources_client.dart'
    show
        HtSourcesClient,
        SourceFetchFailure,
        SourceNotFoundException,
        SourceCreateFailure,
        SourceUpdateFailure,
        SourceDeleteFailure;

// Models
export 'src/models/source.dart' show Source;
