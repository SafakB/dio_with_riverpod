import 'dart:developer';

import 'package:dio_app/models/property_model.dart';
import 'package:dio_app/providers/global_provider.dart';
import 'package:dio_app/providers/property_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddAdvert extends ConsumerStatefulWidget {
  const AddAdvert({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddAdvertState();
}

class _AddAdvertState extends ConsumerState<AddAdvert> {
  late TextEditingController advertTitle;

  @override
  void initState() {
    super.initState();
    advertTitle = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    advertTitle.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var breadcrumb = ref.watch(breadcrumbProvider);
    //var selectedCategory = ref.watch(selectedCategoryProvider);
    var properties = ref.watch(propertyProvider);
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(breadcrumb.join(' / ')),
                ),
                Container(
                  color: Colors.grey.shade200,
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Row(
                      children:[
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: 120,
                          child: const Text('İlan Başlığı')
                        ),
                        Expanded(
                          child: TextField(
                            controller: advertTitle,
                            decoration:   InputDecoration(
                              hintText: 'Temiz Iphone 6s Plus 128GB garantili',
                              hintStyle: const TextStyle(fontSize: 12,color: Colors.grey),
                              border: InputBorder.none,
                              fillColor: Colors.grey.shade100,
                              filled: true
                            ),
                          ),
                        ),
                      ],
                  ),
                ),
                Container(
                  color: Colors.grey.shade200,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                      children:[
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: 120,
                          child: const Text('Fiyat')
                        ),
                        Expanded(
                          child: TextField(
                            controller: advertTitle,
                            decoration:   InputDecoration(
                              hintText: '0.00',
                              hintStyle: const TextStyle(fontSize: 12,color: Colors.grey),
                              border: InputBorder.none,
                              fillColor: Colors.grey.shade100,
                              filled: true
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: const Text('TL')
                        ),
                      ],
                  ),
                ),
                properties.when(
                  data: (data){
                    return Column(
                      children: [
                        for(var d in data)
                          PropertyField(property: d,)
                      ],
                    );
                  },
                  error: (error,stackTrace)=>Text(error.toString()),
                  loading: ()=>const Center(child: CupertinoActivityIndicator(),)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class PropertyField extends ConsumerStatefulWidget {
  
  final Property property;
  const PropertyField({Key? key,required this.property}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PropertyFieldState();
}

class _PropertyFieldState extends ConsumerState<PropertyField> {
  
  void _showMultiSelect(BuildContext context,Property property) async {
    List<String> values = property.arrays!.split(',');
    final items = values.map((value) => MultiSelectItem<String>(value,value)).toList();
    List<String> list = ref.read(propertyListProvider(property.id!));
    await showModalBottomSheet(
      isScrollControlled: false,
      context: context,
       builder: (ctx) {
        return  MultiSelectDialog(
          title: Text(property.title!),
          items: items,
          initialValue: list,
          onConfirm: (values) {
            var newProperty = Property(id: property.id,title: property.title,arrays: values.join(','));
            ref.read(propertyStoreProvider.notifier).addProperty(newProperty);
            log('${property.id}-$values');
          },
        );
      },
    );
  }

  void _showSingleSelect2(BuildContext context,Property property) async {
    List<String> values = property.arrays!.split(',');
    double heightOfModalBottomSheet = 120;
    String selectedValue = "";
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            height: heightOfModalBottomSheet,
            child: ListView.builder(
                itemCount: values.length,
                itemBuilder: (context, index) {
                    return RadioListTile<String>(
                      value: values[index],
                      groupValue: selectedValue,
                      onChanged: (value){
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                      title: Text(values[index]),
                    );
                },
              ),
            );
          });
      });
  }
  @override
  Widget build(BuildContext context) {
    int valueCount = ref.watch(propertyCountProvider(widget.property.id!));
    return Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
            children:[
              Container(
                padding: const EdgeInsets.all(12),
                width: 120,
                child: Text('${widget.property.title!} ${widget.property.type}'),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey.shade100,
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      valueCount>0?Text("$valueCount seçenek seçildi"):const Text(''),
                      GestureDetector(
                        onTap: () async{
                            if(widget.property.type==3){
                              _showMultiSelect(context,widget.property);
                            }else if(widget.property.type==2){
                              _showSingleSelect2(context,widget.property);
                            }
                        },
                        child: valueCount>0?const Text('Seçildi',style: TextStyle(color: Colors.green),):const Text('Seçiniz',style: TextStyle(color: Colors.red),),
                      ),
                    ],
                  ),
                )
              ),
            ],
        ),
      );
  }
}