class User {
  String? login;
  int? id;
  String? avatarUrl;
  String? url;
  String? followersUrl;
  String? followingUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? type;
  String? name;
  String? company;
  String? location;
  String? bio;
  int? publicRepos;
  int? followers;
  int? following;
  int? contributions;

  User({
    this.login,
    this.contributions,
    this.id,
    this.avatarUrl,
    this.url,
    this.followersUrl,
    this.followingUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.type,
    this.name,
    this.company,
    this.location,
    this.bio,
    this.publicRepos,
    this.followers,
    this.following,
  });

  User.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    contributions = json['contributions'];
    avatarUrl = json['avatar_url'];
    url = json['url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    organizationsUrl = json['organizations_url'];
    reposUrl = json['repos_url'];
    type = json['type'];
    name = json['name'];
    company = json['company'];
    location = json['location'];
    bio = json['bio'];
    publicRepos = json['public_repos'];
    followers = json['followers'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    data['contributions'] = this.contributions;
    data['avatar_url'] = this.avatarUrl;
    data['url'] = this.url;
    data['followers_url'] = this.followersUrl;
    data['following_url'] = this.followingUrl;
    data['organizations_url'] = this.organizationsUrl;
    data['repos_url'] = this.reposUrl;
    data['type'] = this.type;
    data['name'] = this.name;
    data['company'] = this.company;
    data['location'] = this.location;
    data['bio'] = this.bio;
    data['public_repos'] = this.publicRepos;
    data['followers'] = this.followers;
    data['following'] = this.following;
    return data;
  }
}
