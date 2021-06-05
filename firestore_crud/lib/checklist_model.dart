class CheckList {
  final String title;
  final String description;

  CheckList(this.title, this.description);

  factory CheckList.fromJSON(Map<String, dynamic> json) {
    return CheckList(
      json["title"],
      json["description"],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "title": title,
      "description": description,
    };
  }
}
