import 'dart:developer';

import 'package:dio_app/pages/category/category_list.dart';
import 'package:dio_app/pages/list_screens/list_screen.dart';
import 'package:dio_app/pages/list_screens/list_screen2.dart';
import 'package:dio_app/pages/list_screens/list_screen3.dart';
import 'package:dio_app/providers/global_provider.dart';
import 'package:dio_app/service/artonomi_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}



class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  ref.read(breadcrumbProvider.notifier).state = [];
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CategoryList()));
                },
                child: const Text('Category List')
              ),
              ElevatedButton(
                onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListScreen())),
                child: const Text('List Screen (Standart)')
              ),
              ElevatedButton(
                onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListScreen2())),
                child: const Text('List Screen (Riverpod)')
              ),
              ElevatedButton(
                onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListScreen3())),
                child: const Text('List Screen (Riverpod Raw)')
              ),
              ElevatedButton(
                onPressed: (){
                  log('pressed');
                    // ignore: avoid_single_cascade_in_expression_statements
                    //ArtonomiService(endpoint: 'app/postTest',formdata: {'qwe':'asdasd','qw':'as4a65sd4'}).post();
                    //ArtonomiService().getCategories(null);
                },
                child: const Text('Post Data')
              ),
            ],
          ),
        ),
      ),
    );
  }
}

