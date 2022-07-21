class Picture {
  final String previewURL;
  final String tags;

  Picture({
    required this.previewURL,
    required this.tags,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      previewURL: json['previewURL'] as String,
      tags: json['tags'] as String,
    );
  }
}

class Post {
  final String title;
  final String body;

  Post({
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
