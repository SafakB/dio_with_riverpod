import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio_app/models/category_model.dart';
import 'package:dio_app/models/property_model.dart';
import 'package:dio_app/models/user_model.dart';

class ArtonomiService {
  //late Dio dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com/'));
  //late Dio dio = Dio(BaseOptions(baseUrl: 'https://fiko.artonomi.org/api/'));
  late Dio dio = Dio(BaseOptions(baseUrl: 'https://www.alanzii.com/api/'));

  String? token;
  String? endpoint;
  Map<String,dynamic>? formdata;
  
  ArtonomiService({
    this.token,
    this.endpoint,
    this.formdata
  });

  Future<List<Category>> getCategories(int? categoryId)async {
    List<Category> categories = [];
    int categoryid = categoryId ?? 0;

    final response = await dio.get('categories/childs/$categoryid');

    if(response.statusCode==200){
      if(response.data['data']==false){
        return Future.delayed(const Duration(milliseconds: 10),() => [],);
      }else{
        var dataList = (response.data['data'] as List);
        categories = dataList.map((e) => Category.fromJson(e)).toList();
        return categories;
      }

    }
    return Future.delayed(const Duration(milliseconds: 10),() => [],);
  }


  Future<List<Property>> getProperties(int categoryId)async{
    List<Property> properties = [];
    final response = await dio.post('categories/properties/$categoryId');
    if(response.statusCode == 200){
      properties = (response.data['data'] as List).map((e) => Property.fromJson(e)).toList();
    }
    return properties;
  }


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
