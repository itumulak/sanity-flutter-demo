class Movie {
  final String id;
  final String title;
  final String imageUrl;

  const Movie({required this.id, required this.title, required this.imageUrl});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(id: json['_id'], title: json['title'], imageUrl: json['poster']['asset']['url']);
  }
}
