import 'dart:convert';

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));

String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
    List<Detail> details;

    Details({
        required this.details,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
    };
}

class Detail {
    String id;
    String title;
    String type;
    String date;
    String point;
    String buyer;
    List<String> info;

    Detail({
        required this.id,
        required this.title,
        required this.type,
        required this.date,
        required this.point,
        required this.buyer,
        required this.info,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        date: json["date"],
        point: json["point"],
        buyer: json["buyer"],
        info: List<String>.from(json["info"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "date": date,
        "point": point,
        "buyer": buyer,
        "info": List<dynamic>.from(info.map((x) => x)),
    };
}
