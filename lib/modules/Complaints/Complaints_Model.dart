class ComplaintModel {
  final int id;
  final int governmentalEntityId;
  final String location;
  final String description;
  final String status;

  ComplaintModel({
    required this.id,
    required this.governmentalEntityId,
    required this.location,
    required this.description,
    required this.status,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      governmentalEntityId: json['governmentalEntityId'],
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
