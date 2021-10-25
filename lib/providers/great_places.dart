import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:places_app/helpers/db_helper.dart';
import 'package:places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: null,
        image: image);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    
    final dataList =await  DBHelper.getData('user_places');    
    _items = dataList 
        .map(
          (item) => Place(
                id: item['id'],
                title: item['title'],
                image: File(item['image']),
                location: null,
              ),
        )
        .toList();
    notifyListeners();
  

    // final listMap = dataList as List<Map<String, dynamic>>;
    // print(listMap.length);
    // _items = listMap
    //     .map(
    //       (item) => Place(
    //         id: item['id'],
    //         title: item['title'],
    //         location: null,
    //         image: File(item['image']),
    //       ),
    //     )
    //     .toList();


    // print(listMap.isEmpty);
    // print(listMap);
    // List<Place> tempList = [];
    // listMap.forEach((item) {
    //   tempList.add(Place(
    //     id: item['id'],
    //     title: item['title'],
    //     location: null,
    //     image: File(item['image']),
    //   ));
    // });
    // print(tempList);
    // _items = tempList;
    notifyListeners();
  }
}
