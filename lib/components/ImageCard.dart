import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/ItemImage.dart';
import 'package:flutter_application_1/screens/FullImageScreen.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    required this.source,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  final ImageSource source;

  final VoidCallback onTap;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Column(
          children: [
            // ignore: unnecessary_new
            new Container(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullImagePageRoute(
                                  source.imglink, source.author)));
                    },
                    splashColor: Colors.white10,
                    child: Image.network(source.imglink))),
            // ignore: unnecessary_new
            new Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(source.title,
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(source.author,
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                        textAlign: TextAlign.end),
                  ),
                ],
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ));
  }
}
