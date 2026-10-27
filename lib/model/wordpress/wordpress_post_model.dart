class WordpressPosts {
  int? id;
  PostTitle? title;
  PostContent? content;

  WordpressPosts({this.id, this.title, this.content});

  WordpressPosts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = PostTitle.fromJson(json['title']);
    content = PostContent.fromJson(json['content']);
  }
}

///=====================
/// FOR POST TITLE
///=====================

class PostTitle {
  String? rendered;

  PostTitle({this.rendered});

  factory PostTitle.fromJson(Map<String, dynamic> json) =>
      PostTitle(rendered: json["rendered"]);
  @override
  String toString() {
    return removeAllHtmlTags(rendered);
  }

  String removeAllHtmlTags(String? htmlText) {
    RegExp exp = RegExp(r"<[^>]*>|\n", multiLine: true, caseSensitive: true);
    return htmlText!.replaceAll(exp, '');
  }
}

///=====================
/// FOR POST CONTENT
///=====================
class PostContent {
  String? rendered;

  PostContent({this.rendered});

  factory PostContent.fromJson(Map<String, dynamic> json) =>
      PostContent(rendered: json['rendered']);

  @override
  String toString() {
    return removeAllHtmlTags(rendered);
  }

  String removeAllHtmlTags(String? htmlText) {
    RegExp exp = RegExp(r"<[^>]*>|\n", multiLine: true, caseSensitive: true);
    return htmlText!.replaceAll(exp, '');
  }
}
