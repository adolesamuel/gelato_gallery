///used for server exception errors
class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

///Used for general exception
class CommonException implements Exception {
  final String message;

  CommonException(this.message);
}

///Used for cache exception
class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}

///Used for Failed connection exception
class NoInternetException implements Exception {
  final String message;

  NoInternetException(this.message);
}
