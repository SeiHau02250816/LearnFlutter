import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:memoapp/dialogs/sign_out_dialog.dart";
import "package:memoapp/dialogs/add_memo_dialog.dart";
import "package:memoapp/dialogs/delete_memo_dialog.dart";
import "package:memoapp/utils/dependencies.dart" as dependencies;
import "package:intl/intl.dart";

class MemoCard extends StatelessWidget {
  final String timeStamp;
  final String content;
  final int index;
  final Function() scrollToBottom;
  const MemoCard({
    super.key,
    required this.timeStamp,
    required this.content,
    required this.index,
    required this.scrollToBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      color: Colors.white,
      elevation: 5,
      surfaceTintColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.yMEd().add_jms().format(
                        DateTime.parse(timeStamp).add(
                          const Duration(hours: 3),
                        ),
                      ),
                  style: const TextStyle(),
                ),
                const SizedBox(width: 30),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) => DeleteMemoDialog(
                        index: index,
                        scrollToBottom: scrollToBottom,
                      ),
                    );
                  },
                ),
              ],
            ),
            const Divider(),
            Text(content),
          ],
        ),
      ),
    );
  }
}

// Memo page
class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  var memoController = TextEditingController();
  RxString status = "type-memo".obs;
  var scrollController = ScrollController();
  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!Get.find<dependencies.AuthController>().isSignedIn.value) {
          Get.toNamed("/home_page");
        }
        if (Get.find<dependencies.AuthController>().memos.isNotEmpty) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: const SizedBox.shrink(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: InkWell(
              child: const Row(
                children: [
                  Text(
                    "Sign out",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.logout,
                  ),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const SignOutDialog(),
                );
              },
            ),
          ),
        ],
        title: Center(
          child: Text(
            Get.find<dependencies.AuthController>().signInEmail.value,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.0,
                colors: [
                  Colors.white,
                  Color(0xff5debd7),
                  Colors.white,
                ],
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Obx(
                () => Get.find<dependencies.AuthController>().memos.isEmpty
                    ? const Center(
                        child: Text("No memos yet!"),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 130.0,
                        ),
                        itemCount: Get.find<dependencies.AuthController>()
                            .memos
                            .length,
                        itemBuilder: (context, index) => MemoCard(
                          timeStamp: Get.find<dependencies.AuthController>()
                              .memos[index]["timeStamp"],
                          content: Get.find<dependencies.AuthController>()
                              .memos[index]["content"],
                          index: index,
                          scrollToBottom: scrollToBottom,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(
          top: 5.0,
          left: 5,
          right: 5,
          bottom: 20,
        ),
        child: IconButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Colors.white,
            ),
            foregroundColor: WidgetStatePropertyAll(
              Colors.black,
            ),
          ),
          icon: const Icon(
            Icons.add,
            size: 50,
          ),
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) => AddMemoDialog(
                scrollToBottom: scrollToBottom,
              ),
            );
          },
        ),
      ),
    );
  }
}
