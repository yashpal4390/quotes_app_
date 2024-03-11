import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/Modul/FavoritePage/favorite_page_controller.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoritePageController favoritePageController =
  Get.put(FavoritePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Quotes"),
        centerTitle: true,
      ),
      body: Obx(() {
        return favoritePageController.favoriteQuotes.isEmpty
            ? Center(child: Text("No Favorite Quote"))
            : ListView.builder(
          itemCount: favoritePageController.favoriteQuotes.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 2.0,
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                title: Text(
                  favoritePageController.favoriteQuotes[index],
                  style: TextStyle(fontSize: 16.0),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    await favoritePageController.removeFromFavorites(
                        favoritePageController.favoriteQuotes[index]);
                  },
                  icon: Icon(Icons.close),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                onTap: () {},
              ),
            );
          },
        );
      }),
    );
  }
}
