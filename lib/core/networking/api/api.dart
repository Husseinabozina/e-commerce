import 'package:dio/dio.dart';

abstract class Api {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
  }

  Future get(
      {required String url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? data,
      String lang = 'ar',
      String? token});
  Future post({
    required String url,
    Map<String, dynamic> query,
    required Map<String, dynamic> data,
  });
  Future put(
      {required String url,
      Map<String, dynamic> query,
      required Map<String, dynamic> data,
      String lang = 'ar',
      String? token});
  Future delete({
    required String url,
    Map<String, dynamic> data,
  });
}

class ApiImpl extends Api {
  @override
  delete({required String url, Map<String, dynamic>? data}) async {
    Api.dio.options.headers = {
      'Content-Type': 'application/json',
    };
    return await Api.dio.delete(url, data: data);
  }

  @override
  get(
      {required String url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? data,
      String lang = 'ar',
      String? token}) async {
    Api.dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token ?? '',
    };
    return Api.dio.get(url, queryParameters: query, data: data);
  }

  @override
  post(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data}) async {
    Api.dio.options.headers = {
      'Content-Type': 'application/json',
    };
    return await Api.dio.post(url, queryParameters: query, data: data);
  }

  @override
  put(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String lang = 'ar',
      String? token}) async {
    Api.dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token ?? '',
    };
    return await Api.dio.put(url, queryParameters: query, data: data);
  }
}
