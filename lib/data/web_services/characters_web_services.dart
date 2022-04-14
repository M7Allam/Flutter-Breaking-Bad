import 'package:dio/dio.dart';
import 'package:flutter_breaking_bad/shared/values/strings.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20*1000,
      receiveTimeout: 20*1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async{
    Response response = await dio.get('characters');
    return response.data;
  }

}