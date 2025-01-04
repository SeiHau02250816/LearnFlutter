import "package:get/get.dart";
import "package:memoapp/pages/home_page.dart";
import "package:memoapp/pages/memo_page.dart";

class Routes {
  static const String homePage = "/home_page";
  static const String memoPage = "/memo_page";
}

final getPages = [
  GetPage(name: Routes.homePage, page: () => const HomePage()),
  GetPage(name: Routes.memoPage, page: () => const MemoPage()),
];
