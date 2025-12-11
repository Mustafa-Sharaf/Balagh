class Complaint {
  final int id;
  final int governmentalEntityId;
  final String location;
  final String description;
  final String status;
  final String rowVersion;
  final List<String> files;

  Complaint({
    required this.id,
    required this.governmentalEntityId,
    required this.location,
    required this.description,
    required this.status,
    required this.files,
    required this.rowVersion
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json["id"],
      governmentalEntityId: json["governmentalEntityId"],
      location: json["location"],
      description: json["description"],
      status: json["status"],
      rowVersion: json["rowVersion"],
      files: (json["complaintFiles"] as List)
          .map((file) => file["path"].toString())
          .toList(),
    );
  }
}
