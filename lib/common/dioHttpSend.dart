
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:wechat/common/config.dart';

class DioHttpSend {
  static Dio _dio;
  static BaseOptions _options = new BaseOptions(
    baseUrl: Config['http_url'],
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {
      HttpHeaders.userAgentHeader: "dio",
      "api": "1.0.0",
    },
    contentType: ContentType.json,
    responseType: ResponseType.plain,
  );

 static Dio buildDio() {
    if (_dio == null) {
      _dio = new Dio(_options);
    }
    return _dio;
  }

  static get(String url, Function successCallBak, Function failure) async {
      Dio dio = buildDio();
      try {
          Response<Map> responseMap = await dio.get(url);
          successCallBak(responseMap.data);
      } catch (exception) {
          failure(exception);
      }
  }

  static post(String url, params, Function successCallBak, Function failure) async {
      Dio dio = buildDio();
      try {
         Response<Map> responseMap = await dio.post(url, data: params, options: new Options(
                contentType: ContentType.parse("application/x-www-form-urlencoded"),
                responseType: ResponseType.json
                )
            );
        successCallBak(responseMap.data);
      } catch (exception) {
        failure(exception);
      }
  }
  
}
