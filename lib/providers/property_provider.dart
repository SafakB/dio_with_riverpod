import 'package:dio_app/models/property_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final propertyStoreProvider = StateNotifierProvider<PropertyNotifier,List<Property>>((ref) {
  return PropertyNotifier();
});

final propertyCountProvider = StateProvider.family<int,int>((ref,propertyId) {
  var state = ref.watch(propertyStoreProvider);
  int count = 0;
    for(var p in state){
      if(p.id == propertyId){
        count = p.arrays!.split(',').length;
      }
    }
    return count;
});

final propertyListProvider = StateProvider.family<List<String>,int>((ref,propertyId) {
  var state = ref.watch(propertyStoreProvider);
  List<String> list = [];
    for(var p in state){
      if(p.id == propertyId){
        list = p.arrays!.split(',');
      }
    }
    return list;
});

class PropertyNotifier extends StateNotifier<List<Property>>{
  PropertyNotifier(): super([]);

  void addProperty(Property property){
    state = [...state,property];
  }
}