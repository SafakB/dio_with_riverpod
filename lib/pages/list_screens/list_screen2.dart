import 'package:dio_app/providers/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ListScreen2 extends ConsumerWidget {
  const ListScreen2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var users = ref.watch(usersProvider);
    return Scaffold(
      body: SafeArea(
        child: users.when(
          data: ((data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return  ListTile(
                  leading: CircleAvatar(
                    child: Image.network(data[index].image!),
                  ),
                  title: Text("${data[index].firstName} ${data[index].lastName}"),
                  subtitle: Text("Age : ${data[index].age}, Gender : ${data[index].gender}"),
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
