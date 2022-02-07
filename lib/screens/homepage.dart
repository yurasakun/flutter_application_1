import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/ImageCard.dart';
import 'package:flutter_application_1/models/ItemImage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

Future<List<ImageSource>> fetchImages(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9'));

  return compute(parseImage, response.body);
}

List<ImageSource> parseImage(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ImageSource>((json) => ImageSource.fromJson(json)).toList();
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageWidgetState();
}

class HomePageWidgetState extends State<HomePage> {
  late Future<List<ImageSource>> imageSourse;

  Future<void> _refreshImage() async {
    print("refreshed");

    setState(() {
      imageSourse = fetchImages(http.Client());
    });
  }

  @override
  Widget build(BuildContext context) {
    // fetchImageSource();
    imageSourse = fetchImages(http.Client());
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: const Text("Unsplash", style: TextStyle(color: Colors.black87)),
        elevation: 0.0,
        titleSpacing: 0,
        leading: IconButton(
          color: Colors.black87,
          onPressed: () {
            _refreshImage();
          },
          icon: Icon(Icons.refresh),
        ),
      ),
      // ignore: unnecessary_new
      body: FutureBuilder<List<ImageSource>>(
        future: imageSourse,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            // ignore: unnecessary_new
            return new MasonryGridView.count(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,

                //padding: const EdgeInsets.all(20.0),
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemBuilder: (context, index) {
                  return Center(
                    child: ImageCard(
                      source: snapshot.data![index],
                      onTap: () {},
                      selected: true,
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
