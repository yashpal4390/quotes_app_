import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Model/q_model.dart';

class RandomQuoteController extends GetxController {
  List<RandomQuote> random = [];
  int cIndex = 0;
  RxString quote = "".obs;

  void onInit() {
    super.onInit();
    getApiData();
  }

  void getApiData() async {
    var response =
    await http.get(Uri.parse("https://api.quotable.io/quotes/random"));
    if (response.statusCode == 200) {
      random = randomQuoteFromJson(response.body);
      if (random.isNotEmpty) {
        quote.value = random[0].content!;
        update();
        print("LENGTH==> ${random.length}");
      }
    } else {
      print("Failed to fetch data: ${response.statusCode}");
    }
  }

}
