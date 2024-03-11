// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quotes/Modul/SecondPage/second_page_controller.dart';

import 'home_screen_contoller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

HomeController homeController = Get.put(HomeController());
SecondPageController secondPageController = Get.put(SecondPageController());

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      homeController.goToRandomQuotePage();
                    },
                    icon: Icon(Icons.online_prediction_rounded)),
                Text("Quote",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                IconButton(
                    onPressed: () {
                      homeController.goToFavoritePage();
                    },
                    icon: Icon(Icons.favorite_border_sharp)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Categories",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: homeController.allQuote.value.length,
                  itemBuilder: (context, index) {
                    if (index < homeController.bgImages.length) {
                      return InkWell(
                        onTap: () {
                          secondPageController.sel_index.value = index;
                          secondPageController.currentCategory.value =
                              homeController.categories[
                                  secondPageController.sel_index.value];
                          print("${secondPageController.currentCategory}");
                          homeController.goToSecondPage();
                        },
                        child: Container(
                          height: 130,
                          width: 300,
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            image: DecorationImage(
                              image: AssetImage(homeController.bgImages[index]),
                              fit: BoxFit.fill,
                            ),
                            color: Colors.blueGrey,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                height: 30,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.black54,
                                ),
                                child: Center(
                                  child: Text(
                                    homeController.categories[index],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
