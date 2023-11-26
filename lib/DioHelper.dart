
import 'package:dio/dio.dart';
class DioHelper{
  static Dio? dio;
  static init(){
    dio = Dio(
        BaseOptions(
            baseUrl: 'http://192.168.4.1/',
            receiveDataWhenStatusError: true
        )
    );
  }
  static Future<Response> postData(String url ,Map<String,dynamic> query) async {
    return await dio!.post(url,queryParameters: query);
  }
  static Future<Response> getData(String url) async{
    return await dio!.get(url);
  }
}
