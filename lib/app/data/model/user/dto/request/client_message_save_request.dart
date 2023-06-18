class ClientMessageSaveRequest {
  final String? massege;
  final int? customerId;
  final DateTime? date;
  final int? appId;
  final int? branchId;
  final int? createdBy;
  final int? companyId;

  const ClientMessageSaveRequest(
      {this.appId,
      this.branchId,
      this.companyId,
      this.createdBy,
      this.customerId,
      this.date,
      this.massege});

  Map<String, dynamic> toJson() => {
        "appId": appId,
        "massege": massege,
        "branchId": branchId,
        "companyId": companyId,
        "createdBy": createdBy,
        "customerId": customerId,
        "date": date?.toIso8601String(),
      };
}
