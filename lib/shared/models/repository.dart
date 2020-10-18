class Repository {
  int id;
  String nodeId;
  String name;
  String fullName;
  String description;
  String language;

  Repository({
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
    this.description,
    this.language,
  });

  Repository.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeId = json['node_id'];
    name = json['name'];
    fullName = json['full_name'];
    description = json['description'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['name'] = this.name;
    data['full_name'] = this.fullName;
    data['description'] = this.description;
    data['language'] = this.language;
    return data;
  }
}
