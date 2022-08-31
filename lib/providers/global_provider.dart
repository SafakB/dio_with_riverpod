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





