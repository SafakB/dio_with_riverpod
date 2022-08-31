import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio_app/models/user_model.dart';

class ArtonomiService {
  late Dio dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com/'));
  //late Dio dio = Dio(BaseOptions(baseUrl: 'https://fiko.artonomi.org/api/'));
  String? token;
  String? endpoint;
  Map<String,dynamic>? formdata;
  
  ArtonomiService({
    this.token,
    this.endpoint,
    this.formdata
  });

  Future<List<User>> getUsers()async {
    List<User> users = [];
    final response = await dio.get('users');
    if(response.statusCode==200){
        users = (response.data['users'] as List).map((e) => User.fromJson(e)).toList();
        return users;
    }
    return Future.delayed(const Duration(seconds: 1),() => [],);
  }

  Future<dynamic> getRaw()async {
    if(endpoint!=null){
      final response = await dio.get(endpoint!);
      if(response.statusCode==200){
          var data = response.data;
          return data;
      }
    }
    return Future.delayed(const Duration(seconds: 1),() => null,);
  }

  Future<dynamic> post()async {
    if(endpoint!=null && formdata!=null){
      try{
        final response = await dio.post(
          endpoint!,
          data: FormData.fromMap(formdata!),
          options: Options(
            headers: {
              "Authorization": "Basic ${base64.encode(utf8.encode('qweqweqw:555555555555555555555'))}"
            },
          ),
        );
        if(response.statusCode==200){
            var data = response.data;
            log(data.toString());
            return data;
        }
      }on DioError catch(e){
        if(e.response!.statusCode == 404){
          log(e.response!.statusCode.toString());
          log(e.response!.statusMessage.toString());
          log(e.message);
        }else{
          log(e.message);
        }
      }
      
    }
    return Future.delayed(const Duration(seconds: 1),() => null,);
  }

}
