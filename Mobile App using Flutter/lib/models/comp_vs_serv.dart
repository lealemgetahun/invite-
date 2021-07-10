class Comp_vs_serv{
  final int ID;
  final int CompanyId;
  final int ServiceId;

  Comp_vs_serv({this.ID,this.CompanyId,this.ServiceId});
  factory Comp_vs_serv.fromJson(Map<String, dynamic> json) => _$FromJson(json);
}
Comp_vs_serv _$FromJson(Map<String, dynamic> json) {
  return Comp_vs_serv(
    ID: json['ID'] as int,
    CompanyId: json['CompanyID'] as int,
    ServiceId: json['ServiceID'] as int,



  );

}
Map<String, dynamic> _$ToJson(Comp_vs_serv instance) =>
    <String, dynamic>{
      'CompanyId': instance.CompanyId,
      'ServiceId': instance.ServiceId,
      'ID': instance.ID,
    };