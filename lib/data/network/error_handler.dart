// ignore: constant_identifier_names
import 'package:dio/dio.dart';
import 'package:flutteradvancedmvvm/data/network/failure.dart';
import 'package:flutteradvancedmvvm/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

enum DataSource {
  // ignore: constant_identifier_names
  SUCCESS,
  // ignore: constant_identifier_names
  NO_CONTENT,
  // ignore: constant_identifier_names
  BAD_REQUEST,
  // ignore: constant_identifier_names
  FORBIDDEN,
  // ignore: constant_identifier_names
  UNAUTHORIZED,
  // ignore: constant_identifier_names
  NOT_FOUND,
  // ignore: constant_identifier_names
  INTERNAL_SERVER_ERROR,
  // ignore: constant_identifier_names
  CONNECT_TIMEOUT,
  // ignore: constant_identifier_names
  CANCEL,
  // ignore: constant_identifier_names
  RECEIVE_TIMEOUT,
  // ignore: constant_identifier_names
  SEND_TIMEOUT,
  // ignore: constant_identifier_names
  CACHE_ERROR,
  // ignore: constant_identifier_names
  NO_INTERNET_CONNECTION,
  // ignore: constant_identifier_names
  DEFAULT
  // ignore: constant_identifier_names
}

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      //? dio error so its error from response of the API
      failure = _handleError(error);
    } else {
      //? default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORIZED:
            return DataSource.UNAUTHORIZED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }

      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioErrorType.other:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(
            ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST.tr());

      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN.tr());

      case DataSource.UNAUTHORIZED:
        return Failure(
            ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORISED.tr());

      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND.tr());

      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR.tr());

      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT.tr());

      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL.tr());

      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT.tr());

      case DataSource.SEND_TIMEOUT:
        return Failure(
            ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT.tr());

      case DataSource.CACHE_ERROR:
        return Failure(
            ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR.tr());

      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION.tr());
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT.tr());
      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT.tr());
    }
  }
}

class ResponseCode {
  //! API STATUS CODE
  // ignore: constant_identifier_names
  static const int SUCCESS = 200; //? success with data
  // ignore: constant_identifier_names
  static const int NO_CONTENT = 201; //? success with no content
  // ignore: constant_identifier_names
  static const int BAD_REQUEST = 400; //? failure, api rejected the request
  // ignore: constant_identifier_names
  static const int FORBIDDEN = 403; //? failure, api rejected the request
  // ignore: constant_identifier_names
  static const int UNAUTHORIZED = 401; //? failure user is not authorized
  // ignore: constant_identifier_names
  static const int NOT_FOUND = 404; //? failure, api url is not found
  // ignore: constant_identifier_names
  static const int INTERNAL_SERVER_ERROR =
      500; //? failure, crash happened in server side

  //! LOCAL STATUS CODE
  // ignore: constant_identifier_names
  static const int DEFAULT = -1;
  // ignore: constant_identifier_names
  static const int CONNECT_TIMEOUT = -2;
  // ignore: constant_identifier_names
  static const int CANCEL = -3;
  // ignore: constant_identifier_names
  static const int RECEIVE_TIMEOUT = -4;
  // ignore: constant_identifier_names
  static const int SEND_TIMEOUT = -5;
  // ignore: constant_identifier_names
  static const int CACHE_ERROR = -6;
  // ignore: constant_identifier_names
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  //! API STATUS CODE
  // ignore: constant_identifier_names
  // API status codes
  // API response codes
  // ignore: constant_identifier_names
  static const String SUCCESS = AppStrings.success; // success with data
  // ignore: constant_identifier_names
  static const String NO_CONTENT =
      AppStrings.noContent; // success with no content
  // ignore: constant_identifier_names
  static const String BAD_REQUEST =
      AppStrings.badRequestError; // failure, api rejected our request
  // ignore: constant_identifier_names
  static const String FORBIDDEN =
      AppStrings.forbiddenError; // failure,  api rejected our request
  // ignore: constant_identifier_names
  static const String UNAUTHORISED =
      AppStrings.unauthorizedError; // failure, user is not authorised
  // ignore: constant_identifier_names
  static const String NOT_FOUND = AppStrings
      .notFoundError; // failure, API url is not correct and not found in api side.
  // ignore: constant_identifier_names
  static const String INTERNAL_SERVER_ERROR =
      AppStrings.internalServerError; // failure, a crash happened in API side.

  // local responses codes
  // ignore: constant_identifier_names
  static const String DEFAULT =
      AppStrings.defaultError; // unknown error happened
  // ignore: constant_identifier_names
  static const String CONNECT_TIMEOUT =
      AppStrings.timeoutError; // issue in connectivity
  // ignore: constant_identifier_names
  static const String CANCEL =
      AppStrings.defaultError; // API request was cancelled
  // ignore: constant_identifier_names
  static const String RECEIVE_TIMEOUT =
      AppStrings.timeoutError; //  issue in connectivity
  // ignore: constant_identifier_names
  static const String SEND_TIMEOUT =
      AppStrings.timeoutError; //  issue in connectivity
  // ignore: constant_identifier_names
  static const String CACHE_ERROR = AppStrings
      .defaultError; //  issue in getting data from local data source (cache)
  // ignore: constant_identifier_names
  static const String NO_INTERNET_CONNECTION =
      AppStrings.noInternetError; // issue in connectivity
}

class ApiInternalStatus {
  // ignore: constant_identifier_names
  static const int SUCCESS = 0;
  // ignore: constant_identifier_names
  static const int Failure = -1;
}
