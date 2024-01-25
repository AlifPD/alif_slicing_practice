class NewsModels {
  String? author;
  String? title;
  String? description;
  String? imgUrl;
  String? publishedTime;
  String? content;

  NewsModels(
      {this.author,
      this.title,
      this.description,
      this.imgUrl,
      this.publishedTime,
      this.content});

  NewsModels.fromJson(Map<String, dynamic> json) {
    author = json["author"];
    title = json["title"];
    description = json["description"];
    imgUrl = json["urlToImage"];
    publishedTime = json["publishedAt"];
    content = json["content"];
  }
}
