class RequestLogin {
  RequestLogin({
    this.username,
    this.password,
  });

  String username;
  String password;

  factory RequestLogin.fromJson(Map<String, dynamic> json) => RequestLogin(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
