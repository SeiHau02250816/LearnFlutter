import "package:flutter/material.dart";
import "package:get/get.dart";
import "../utils/dependencies.dart" as dependencies;

class AddMemoDialog extends StatefulWidget {
  final Function scrollToBottom;
  const AddMemoDialog({
    super.key,
    required this.scrollToBottom,
  });

  @override
  State<AddMemoDialog> createState() => _AddMemoDialogState();
}

class _AddMemoDialogState extends State<AddMemoDialog> {
  RxString status = 'type-memo'.obs;
  var memoController = TextEditingController(text: '');

  Widget typeMemoWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 400,
          child: TextField(
            controller: memoController,
            decoration: const InputDecoration(
              hintText: 'Enter a memo',
            ),
            maxLines: null,
          ),
        ),
        const SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              status.value = 'adding-memo';
            },
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ]),
      ],
    ));
  }

  Widget addingMemoWidget() {
    // Use future builder here because we need to wait for memo addition process
    // to run in the background.
    return FutureBuilder(
      future: Get.find<dependencies.AuthController>().addMemo(
        memoController.text,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Adding memo...'),
                SizedBox(height: 20),
                CircularProgressIndicator()
              ],
            ),
          );
        } else if (snapshot.data == "Success") {
          Future.delayed(
            const Duration(milliseconds: 500),
            () {
              widget.scrollToBottom();
              Navigator.pop(context);
            },
          );

          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Memo Added Successfully!'),
                SizedBox(height: 20),
                CircularProgressIndicator()
              ],
            ),
          );
        } else {
          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(snapshot.data!),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ]),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => status.value == 'type-memo'
            ? typeMemoWidget()
            : status.value == 'adding-memo'
                ? addingMemoWidget()
                : const SizedBox(),
      ),
    );
  }
}
