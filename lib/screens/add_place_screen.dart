import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/widgets/image_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const String routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();
    File _pickedImage;

    void _selectImage(File pickedImage) {
      _pickedImage = pickedImage;
    }

    void _savePlace() {
      if (_titleController.text.isEmpty || _pickedImage == null) {
        return;
        //show error messages
      }
      Provider.of<GreatPlaces>(context, listen: false)
          .addPlace(_titleController.text, _pickedImage);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //items now take full width
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      //not textformfield so need manual validation and controller
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            elevation: 0, //loses shadow
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
