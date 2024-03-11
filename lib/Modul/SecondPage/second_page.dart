// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/Modul/SecondPage/second_page_controller.dart';

import '../HomePage/home_screen_contoller.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

HomeController homeController = Get.find<HomeController>();
SecondPageController secondPageController = Get.find<SecondPageController>();

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quote", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            secondPageController.goToHomePage();
          },
          icon: Icon(
            Icons.home,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeTheme(ThemeData.light());
              } else {
                Get.changeTheme(ThemeData.dark());
              }
            },
            icon: Icon(Icons.dark_mode, color: Colors.black),
          ),
          IconButton(
              onPressed: () {
                secondPageController.goToFavoritePage();
              },
              icon: Icon(
                Icons.favorite_border,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeController.categories.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        secondPageController.sel_index.value = index;
                        secondPageController.currentCategory.value =
                            homeController.categories[
                                secondPageController.sel_index.value];
                        print("${secondPageController.currentCategory}");
                      },
                      child: Container(
                        height: 40,
                        width: 51,
                        margin: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage(secondPageController.images[index]),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text(homeController.categories[index]),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 170,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Obx(
                  () => Container(
                    height: 160,
                    width: 380,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(secondPageController
                            .bgImages[secondPageController.sel_index.value]),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment(-0.9, -0.7),
                      child: ActionChip(
                        label: Title(
                          color: Colors.white,
                          child: Text(
                            secondPageController.currentCategory.value,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 400,
            child: Obx(
              () => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: secondPageController
                    .getQuote(secondPageController.currentCategory.value)
                    .length,
                itemBuilder: (context, index) {
                  var quote = secondPageController.getQuote(
                      secondPageController.currentCategory.value)[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        // qt_index = index;
                        // Navigator.pushNamed(context, detail_page,
                        //     arguments: [quote ?? "", bgImages[sel_index] ?? ""]);
                        print("QUOTE ==> ${quote}");
                        secondPageController.goToDetailPage(
                            quote ?? "",
                            secondPageController.bgImages[
                                secondPageController.sel_index.value]);
                        print("CLICKED ==>");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(secondPageController.bgImages[
                                secondPageController.sel_index.value]),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Text(quote,
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
