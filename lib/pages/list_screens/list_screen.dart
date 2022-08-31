import 'package:dio_app/models/user_model.dart';
import 'package:dio_app/service/artonomi_service.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: ArtonomiService().getUsers(),
          builder: ((context, snapshot) {
              if(snapshot.hasData){
                  var users = snapshot.data as List<User>;
                  return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: ((context, index) {
                    return  ListTile(
                      leading: CircleAvatar(
                        child: Image.network(users[index].image!),
                      ),
                      title: Text("${users[index].firstName} ${users[index].lastName}"),
                      subtitle: Text("Age : ${users[index].age}, Gender : ${users[index].gender}"),
                    );
                  }),
                );
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }
              
          }),
        ),
      )
    );
  }
}