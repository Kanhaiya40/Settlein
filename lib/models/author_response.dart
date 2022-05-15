class Author {
  String? id;
  String? author;
  int? width;

  @override
  String toString() {
    return 'Author{id: $id, author: $author, width: $width, height: $height, url: $url, downloadUrl: $downloadUrl}';
  }

  int? height;
  String? url;
  String? downloadUrl;

  Author(
      {this.id,
        this.author,
        this.width,
        this.height,
        this.url,
        this.downloadUrl});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['download_url'] = this.downloadUrl;
    return data;
  }
}
