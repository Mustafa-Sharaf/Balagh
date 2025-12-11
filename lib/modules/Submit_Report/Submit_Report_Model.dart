class ComplaintCreateModel {
  final String userId;
  final int governmentalEntityId;
  final String location;
  final String description;
  final List<String> complaintFiles;

  ComplaintCreateModel({
    required this.userId,
    required this.governmentalEntityId,
    required this.location,
    required this.description,
    required this.complaintFiles,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "governmentalEntityId": governmentalEntityId,
      "location": location,
      "description": description,
      "complaintFiles": complaintFiles,
    };
  }
}





class GovernmentalEntity {
  final int id;
  final String name;
  final String address;

  GovernmentalEntity({
    required this.id,
    required this.name,
    required this.address,
  });

  factory GovernmentalEntity.fromJson(Map<String, dynamic> json) {
    return GovernmentalEntity(
      id: json["id"],
      name: json["name"],
      address: json["address"],
    );
  }
}
