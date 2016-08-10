// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart' show AnalysisError;
import 'package:analyzer/src/generated/engine.dart' show AnalysisContext;
import 'package:kernel/analyzer/loader.dart' show AnalyzerLoader;
import 'package:kernel/kernel.dart' show Library, Repository;
import 'package:path/path.dart' as path;

/// The results returned by loader: a Kernel IR [Library] and a list of Analyzer
/// [AnalysisError]s.
class LoaderResult {
  final Library library;
  final List<AnalysisError> errors;

  LoaderResult(this.library, this.errors);
}

/// The class responsible for loading Kernel IR from Dart source and
/// (eventually) from summary files.
///
/// Currently, this just calls [AnalyzerLoader] to load everything.
class Loader {
  final Repository repository;
  final AnalyzerLoader _loader;

  /// Initializes an instance of [Loader] which loads libraries into an
  /// [AnalyzerRepository].
  ///
  /// This involves loading the Dart core libraries. The current implementation
  /// takes several seconds to parse and load these core libraries.
  Loader(Repository repository)
      : repository = repository,
        _loader = new AnalyzerLoader(repository, strongMode: true) {
    // Load the core libraries
    _loader.ensureLibraryIsLoaded(
        _loader.getLibraryReference(_loader.getDartCoreLibrary()));
  }

  /// Provides access to the underlying [AnalyzerLoader]'s [AnalysisContext].
  AnalysisContext get context => _loader.context;

  /// Loads a library by URI.
  LoaderResult loadUri(Uri sourceUri) {
    Library library = repository.getLibraryReference(sourceUri);
    _loader.ensureLibraryIsLoaded(library);

    // Compute errors. The type of source is not annotated because it's an
    // Analyzer internal class (Source, in analyzer/src/generated/source.dart)
    var source = context.sourceFactory.forUri2(sourceUri);
    List<AnalysisError> errors = context.computeErrors(source);
    return new LoaderResult(library, errors);
  }

  /// Loads a Dart source file.
  LoaderResult load(String source) {
    Uri sourceUri = Uri.parse(source);
    if (sourceUri.scheme == '') {
      sourceUri = path.toUri(path.absolute(source));
    }
    return loadUri(sourceUri);
  }

  /// Recursively loads everything referenced by the libraries that have already
  /// been loaded.
  ///
  /// Eventually, this will be replaced by loading signatures from .sob files
  /// and falling back on analyzer to generate signatures if needed.
  void loadEverything() => _loader.loadEverything();
}
