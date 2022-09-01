
import 'package:dio_app/models/property_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectPropertyScreen extends ConsumerWidget {
  final Property property;
  const SelectPropertyScreen({Key? key,required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            property.type==3?MultipleSelect(property: property,): const SizedBox(),
            property.type==2?const Text('single'): const SizedBox(),
          ],
        ),
      )
    );
  }
}

class MultipleSelect extends ConsumerStatefulWidget {
  final Property property;
  const MultipleSelect({Key? key,required this.property}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MultipleSelectState();
}

class _MultipleSelectState extends ConsumerState<MultipleSelect> {
  late List<String> values;
  @override
  void initState() {
    super.initState();
    values = widget.property.arrays!.split(',');
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
          itemCount: values.length,
          itemBuilder: (context, index) {
              return ListTile(
                title: Text(values[index]),
              );
          },
        ),
      ),
    );
  }
}