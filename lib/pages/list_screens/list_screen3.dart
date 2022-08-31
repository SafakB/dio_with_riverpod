import 'package:dio_app/providers/global_provider.dart';
import 'package:dio_app/service/artonomi_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final rawProvider = FutureProvider<dynamic>((ref) async {
  var service = ArtonomiService(
    token: ref.watch(tokenProvider),
    endpoint: 'users',
  );
  var users = await service.getRaw();
  return users;
});

class ListScreen3 extends ConsumerWidget {
  const ListScreen3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var users = ref.watch(rawProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.refresh(rawProvider),
        child: const Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: users.when(
          data: ((data) {
            var users = data['users'];
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: ((context, index) {
                return  ListTile(
                  leading: CircleAvatar(
                    child: Image.network(users[index]['image']!),
                  ),
                  title: Text("${users[index]['firstName']} ${users[index]['lastName']}"),
                  subtitle: Text("Age : ${users[index]['age']}, Gender : ${users[index]['gender']}"),
                );
              }),
            );
          }),
          error: (error,stc)=>Text(error.toString()),
          loading: ()=>const Center(child: CircularProgressIndicator())
        ),
      )
    );
  }
}
