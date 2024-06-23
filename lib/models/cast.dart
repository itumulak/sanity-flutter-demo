class Cast {
  final int id;
  final String name;
  final String imgUrl;
  final int imgWidth;
  final int imgHeight;

  Cast({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.imgWidth,
    required this.imgHeight,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['person']['_id'],
      name: json['person']['name'],
      imgUrl: json['person']['image']['asset']['url'],
      imgWidth: json['person']['image']['asset']['metadata']['dimensions']['width'],
      imgHeight: json['person']['image']['asset']['metadata']['dimensions']['height'],
    );
  }
}
