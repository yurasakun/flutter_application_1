import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/ImageCard.dart';
import 'package:flutter_application_1/models/ItemImage.dart';
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
  @override
  Widget build(BuildContext context) {
    // fetchImageSource();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            print("You go to home");
          },
          icon: const Icon(Icons.home),
        ),
      ),
      // ignore: unnecessary_new
      body: FutureBuilder<List<ImageSource>>(
        future: fetchImages(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return new ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: List.generate(snapshot.data!.length, (index) {
                  return Center(
                    child: ImageCard(
                      source: snapshot.data![index],
                      onTap: () {},
                      selected: true,
                    ),
                  );
                }));
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
