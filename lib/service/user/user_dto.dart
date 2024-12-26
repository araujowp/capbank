class UserDTO {
  final int id;
  final String name;
  final String photo;

  UserDTO({
    required this.id,
    required this.name,
    required this.photo,
  });

  factory UserDTO.fromMap(Map<String, dynamic> map) {
    return UserDTO(
      id: map['id'] != null ? int.tryParse(map['id'].toString()) ?? 0 : 0,
      name: map['name'] ?? '',
      photo: map['photo'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
    };
  }
}
