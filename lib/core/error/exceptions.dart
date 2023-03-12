import 'package:dio/dio.dart';

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}

class ServerException extends DioError {
  ServerException({required super.requestOptions});
}

class Error404Exception extends DioError {
  Error404Exception({required super.requestOptions});
}
