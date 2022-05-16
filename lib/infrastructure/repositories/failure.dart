import 'package:dio/dio.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class Failure implements Exception {
  final String message;

  const Failure({required this.message});

  factory Failure.fromDioError(DioError dioError) {
    String message;
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = LocaleKeys.error_request_cancelled;
        break;
      case DioErrorType.connectTimeout:
        message = LocaleKeys.error_connection_timeout;
        break;
      case DioErrorType.receiveTimeout:
        message = LocaleKeys.error_receive_timeout;
        break;
      case DioErrorType.response:
        message = _handleError(dioError.response!.statusCode!);
        break;
      case DioErrorType.sendTimeout:
        message = LocaleKeys.error_send_timeout;
        break;
      default:
        message = LocaleKeys.error_no_internet_connection;
        break;
    }
    return Failure(message: message);
  }

  static String _handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        return LocaleKeys.error_bad_request;
      case 404:
        return LocaleKeys.error_request_not_found;
      case 500:
        return LocaleKeys.error_internal_server;
      default:
        return LocaleKeys.sth_went_wrong;
    }
  }

  @override
  String toString() => "Failure(message: $message!)";
}
