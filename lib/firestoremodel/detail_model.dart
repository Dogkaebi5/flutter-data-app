class DetailModel {
  String? uid;
  String? docId;
  String? title;
  int? id;
  String? type;
  DateTime? date;
  int? point;

  DetailModel({
    this.uid,
    this.docId,
    this.title,
    this.id,
    this.type,
    this.date,
    this.point
  });

  DetailModel.clone(DetailModel detail)
    : this(
      uid: detail.uid,
      title: detail.title,
      id: detail.id,
      type: detail.type,
      date: detail.date,
      point: detail.point);
  
  DetailModel.fromJson(json)
  :
    uid = json["uid"],
    title = json["title"],
    id = json["id"],
    type = json["type"],
    date = json["date"].toDate(),
    point = json["point"];

  Map toMap(){
    return {
      "uid": uid,
      "title": title,
      "id": id,
      "type": type,
      "date": date,
      "point": point
    };
  }
}