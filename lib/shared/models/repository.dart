class Repository {
  int? id;
  int? rank;
  String? nodeId;
  String? name;
  String? fullName;
  String? description;
  String? language;
  int? openIssues;
  int? forks;
  int? stars;

  Repository({
    this.id,
    this.stars,
    this.forks,
    this.openIssues,
    this.nodeId,
    this.name,
    this.fullName,
    this.description,
    this.language,
  });

  Repository.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeId = json['node_id'];
    stars = json['stargazers_count'];
    name = json['name'];
    forks = json['forks'];
    openIssues = json['open_issues'];
    fullName = json['full_name'];
    description = json['description'];
    language = json['language'];
  }

  Repository.fromTrending(Map json) {
    stars = json['stars'];
    name = json['name'];
    forks = json['forks'];
    fullName = '${json['author']}/${json['name']}';
    description = json['description'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['stargazers_count'] = this.stars;
    data['name'] = this.name;
    data['open_issues'] = this.openIssues;
    data['forks'] = this.forks;
    data['full_name'] = this.fullName;
    data['description'] = this.description;
    data['language'] = this.language;
    return data;
  }
}
