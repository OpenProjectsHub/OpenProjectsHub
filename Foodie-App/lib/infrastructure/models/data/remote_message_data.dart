

class RemoteMessageData{
  final num? id;
  final String? status;
  RemoteMessageData({this.id, this.status});

  factory RemoteMessageData.fromJson( Map data){
    return RemoteMessageData(
      id: int.tryParse(data["id"]),
      status: data["status"]
    );
  }

}
