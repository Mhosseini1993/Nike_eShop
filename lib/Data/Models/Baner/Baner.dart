class Baner {
  final int id;
  final String image;

  Baner({required this.id, required this.image});

  Baner.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'];
}
