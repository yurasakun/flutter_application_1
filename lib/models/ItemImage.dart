// ignore: file_names
class ImageSource {
  final String title;
  final String author;
  final String imglink;

  ImageSource(
      {required this.title, required this.author, required this.imglink});

  factory ImageSource.fromJson(Map<String, dynamic> json) {
    return ImageSource(
        title: json['alt_description'] != null ? json['alt_description'] : "",
        author: json['user']['name'] as String,
        imglink: json['urls']['regular'] as String);
  }
}
