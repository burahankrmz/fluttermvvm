import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutteradvancedmvvm/app/app_prefs.dart';
import 'package:flutteradvancedmvvm/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// ignore: constant_identifier_names
const String APPLICATION_JSON = 'application/json';
// ignore: constant_identifier_names
const String CONTENT_TYPE = 'content-type';
// ignore: constant_identifier_names
const String ACCEPT = 'accept';
// ignore: constant_identifier_names
const String AUTHORIZATION = 'authorization';
// ignore: constant_identifier_names
const String DEFAULT_LANGUAGE = 'language';

class DioFactory {
  final AppPrefences _appPrefences;
  DioFactory(this._appPrefences);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    int _timeOut = 60 * 1000; //? 1 min
    String language = await _appPrefences.getAppLanguage();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: language, //? todo get language from app prefs
    };

    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        receiveTimeout: _timeOut,
        connectTimeout: _timeOut,
        headers: headers);

    if (kReleaseMode) {
      debugPrint('release mode mo logs');
    } else {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }
    return dio;
  }
}
