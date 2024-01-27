import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef CityCallBack = void Function(String?);

void showAddCityDialog(BuildContext context, CityCallBack callBack) async {
  showDialog(
      context: context,
      builder: (context) {
        return AddCityDialog(callBack);
      });
}

class AddCityDialog extends ConsumerStatefulWidget {
  final CityCallBack callBack;

  const AddCityDialog(this.callBack, {super.key});

  @override
  ConsumerState<AddCityDialog> createState() => _AddCityDialogState();
}

class _AddCityDialogState extends ConsumerState<AddCityDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: SizedBox(
        width: 340,
        height: 200,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Add a city',
                style: TextStyle(
                    fontWeight: FontWeight.w900, fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter city name',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      widget.callBack(_textEditingController.text);
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],),
      ),
    );
  }
}
