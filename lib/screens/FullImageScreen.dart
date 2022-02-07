import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FullImagePageRoute extends StatefulWidget {
  String imageDownloadUrl;
  String Author;

  FullImagePageRoute(this.imageDownloadUrl, this.Author);

  @override
  State<FullImagePageRoute> createState() => _FullImagePageRouteState();
}

class _FullImagePageRouteState extends State<FullImagePageRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Author: " + widget.Author),
        backgroundColor: Colors.black,
      ),
      body: Container(
          child: PhotoView(
        loadingBuilder: (context, event) => new SpinKitWave(
          size: 50.0,
          color: Colors.white30,
        ),
        imageProvider: NetworkImage(widget.imageDownloadUrl),
      )),
    );
  }
}
