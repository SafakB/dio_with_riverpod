import 'package:dio_app/main.dart';
import 'package:dio_app/pages/advert/add_advert.dart';
import 'package:dio_app/providers/global_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryList extends ConsumerWidget {
  final int? categoryId;
  const CategoryList({Key? key,this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var categories = ref.watch(categoryProvider(categoryId??0));
    var breadcrumb = ref.watch(breadcrumbProvider);
    return WillPopScope(
      onWillPop: () async{
          if(breadcrumb.isNotEmpty){
            breadcrumb.removeLast();
            ref.read(breadcrumbProvider.notifier).state = breadcrumb;
          }
          Navigator.pop(context,false);
          return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kategoriler'),
        ),
        body:SafeArea(
          child: Column(
            children: [
              Text(breadcrumb.join(' / ')),
              Expanded(
                child: categories.when(
                  data: (data){
                    if(data.isEmpty){
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => const AddAdvert(),));
                      });
                      return const SizedBox();
                    }else if(data.isNotEmpty){
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              breadcrumb.add(data[index].name!);
                              ref.read(breadcrumbProvider.notifier).state = breadcrumb;
                              ref.read(selectedCategoryProvider.notifier).state = data[index].id;
                              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => CategoryList(categoryId: data[index].id,),));
                            },
                            child: ListTile(
                              trailing: const Icon(CupertinoIcons.chevron_right),
                              title: Text("${data[index].name}"),
                            ),
                          );
                        },
                      );
                    }else{
                      return const Text('Bir Hata Oluştu');
                    }
                  }, 
                  error: (error, stackTrace) => Center(child: Text(error.toString()),), 
                  loading: ()=>const Center(child: CircularProgressIndicator(),),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

