import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/Modul/DetailPage/detail_page_controller.dart';
import '../../Model/db_helper.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

DetailPageController detailPageController = Get.put(DetailPageController());

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    List args = Get.arguments as List;
    String data = args[0];
    String bg = args[1];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("QUOTE"),
        centerTitle: true,
        elevation: 0.1,
      ),
      body: Column(
        children: [
          Container(
            height: 750,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bg),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Text(
                  "\"${data}\"",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              IconButton(
                onPressed: () {
                  print("ADDED TO FAVORITE");
                  addToFavorites(data);
                },
                icon: Icon(Icons.favorite_border, color: Colors.black, size: 45),
              ),
              // SizedBox(width: 20),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(Icons.wallpaper_outlined, color: Colors.black, size: 45),
              // ),
            ],
          )
        ],
      ),
    );
  }

  void addToFavorites(String quote) async {
    bool added = await DbHelper.instance.insertData(quote);
    if (added) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Quote added to favorites'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Quote is already in favorites'),
        ),
      );
    }
  }
}
