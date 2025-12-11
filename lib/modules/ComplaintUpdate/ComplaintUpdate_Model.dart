class ComplaintUpdateModel {
  int governmentalEntityId;
  String location;
  String description;
  String newStatus;
  String rowVersion;

  ComplaintUpdateModel({
    required this.governmentalEntityId,
    required this.location,
    required this.description,
    required this.newStatus,
    required this.rowVersion,
  });

  Map<String, dynamic> toJson() => {
    "governmentalEntityId": governmentalEntityId,
    "location": location,
    "description": description,
    "newStatus": newStatus,
    "rowVersion": rowVersion,
  };
}
