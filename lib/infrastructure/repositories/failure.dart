import 'package:dio/dio.dart';

class Failure implements Exception {
  final String message;

  const Failure({required this.message});

  factory Failure.fromDioError(DioError dioError) {
    String message;
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "LocaleKeys.errorRequestCancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "LocaleKeys.errorConnectionTimeout";
        break;
      case DioErrorType.receiveTimeout:
        message = "LocaleKeys.errorReceiveTimeout";
        break;
      case DioErrorType.response:
        message = _handleError(dioError.response!.statusCode!);
        // message = dioError.message;
        break;
      case DioErrorType.sendTimeout:
        message = "LocaleKeys.errorSendTimeout";
        break;
      default:
        message = "LocaleKeys.errorInternetConnection";
        break;
    }
    return Failure(message: message);
  }

  static String _handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        return "LocaleKeys.errorBadRequest";
      case 404:
        return "LocaleKeys.errorRequestNotFound";
      case 500:
        return "LocaleKeys.errorIntenalServer";
      default:
        return "LocaleKeys.errorSomethingWentWrong";
    }
  }

  @override
  String toString() => "Failure(message: $message!)";
}
