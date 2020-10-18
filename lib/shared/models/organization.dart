class Organization {
  String login;
  int id;
  String nodeId;
  String url;
  String reposUrl;
  String eventsUrl;
  String hooksUrl;
  String issuesUrl;
  String membersUrl;
  String publicMembersUrl;
  String avatarUrl;
  String description;

  Organization({
    this.login,
    this.id,
    this.nodeId,
    this.url,
    this.reposUrl,
    this.eventsUrl,
    this.hooksUrl,
    this.issuesUrl,
    this.membersUrl,
    this.publicMembersUrl,
    this.avatarUrl,
    this.description,
  });

  Organization.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    url = json['url'];
    reposUrl = json['repos_url'];
    eventsUrl = json['events_url'];
    hooksUrl = json['hooks_url'];
    issuesUrl = json['issues_url'];
    membersUrl = json['members_url'];
    publicMembersUrl = json['public_members_url'];
    avatarUrl = json['avatar_url'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['url'] = this.url;
    data['repos_url'] = this.reposUrl;
    data['events_url'] = this.eventsUrl;
    data['hooks_url'] = this.hooksUrl;
    data['issues_url'] = this.issuesUrl;
    data['members_url'] = this.membersUrl;
    data['public_members_url'] = this.publicMembersUrl;
    data['avatar_url'] = this.avatarUrl;
    data['description'] = this.description;
    return data;
  }
}
