class UserDTO {
  String username;

  UserDTO({required this.username});

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      username: json['username'],
    );
  }
}