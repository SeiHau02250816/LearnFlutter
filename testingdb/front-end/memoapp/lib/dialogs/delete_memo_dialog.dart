import "package:flutter/material.dart";
import "package:get/get.dart";
import "../utils/dependencies.dart" as dependencies;

class DeleteMemoDialog extends StatefulWidget {
  final int index;
  final Function() scrollToBottom;
  const DeleteMemoDialog({
    super.key,
    required this.index,
    required this.scrollToBottom,
  });

  @override
  State<DeleteMemoDialog> createState() => _DeleteMemoDialogState();
}

class _DeleteMemoDialogState extends State<DeleteMemoDialog> {
  RxString status = "delete-memo".obs;
  var memoController = TextEditingController();

  String? _statusMessage;
  bool _isLoading = true;

  Widget deleteMemoWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Delete this memo?"),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Delete"),
              onPressed: () {
                status.value = 'deleting-memo';
              },
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    ));
  }

  Widget deletingMemoWidget() {
    return FutureBuilder(
      delayed: true,
      future: Get.find<dependencies.AuthController>().deleteMemo(
        widget.index,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Deleting memo...'),
                SizedBox(height: 20),
                CircularProgressIndicator()
              ],
            ),
          );
        } else if (snapshot.data == "Success") {
          Future.delayed(
            const Duration(milliseconds: 500),
            () {
              if (Get.find<dependencies.AuthController>().memos.isNotEmpty) {
                widget.scrollToBottom();
              }
              Navigator.pop(context);
            },
          );

          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Memo deleted!'),
                SizedBox(height: 20),
                CircularProgressIndicator()
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.data!),
                SizedBox(height: 20),
                ElevatedButton(
                  child: const Text("Close"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => status.value == 'delete-memo'
            ? deleteMemoWidget()
            : status.value == 'deleting-memo'
                ? deletingMemoWidget()
                : const SizedBox(),
      ),
    );
  }
}
