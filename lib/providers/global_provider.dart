import 'dart:developer';

import 'package:dio_app/models/category_model.dart';
import 'package:dio_app/models/property_model.dart';
import 'package:dio_app/models/user_model.dart';
import 'package:dio_app/service/artonomi_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenProvider = StateProvider<String?>((ref) {
  return null;
});

final serviceProvider = Provider<ArtonomiService>((ref) {
  return ArtonomiService(token: ref.watch(tokenProvider));
});

final usersProvider = FutureProvider<List<User>>((ref) async {
  var service = ref.watch(serviceProvider);
  List<User> users = await service.getUsers();
  return users;
});

final categoryProvider = FutureProvider.family<List<Category>,int>((ref,categoryId) async {
  var service = ref.watch(serviceProvider);
  List<Category> categories = await service.getCategories(categoryId);
  return categories;
});

final selectedCategoryProvider = StateProvider<int?>((ref) {
  return;
});

final breadcrumbProvider = StateProvider<List<String>>((ref) {
  return [];
});

final propertyProvider = FutureProvider<List<Property>>((ref) async{
  int? selectedCategory = ref.watch(selectedCategoryProvider);
  var service = ref.watch(serviceProvider);
  List<Property> properties = [];
  if(selectedCategory!=null){
    properties = await service.getProperties(selectedCategory);
  }
  return properties;
});



