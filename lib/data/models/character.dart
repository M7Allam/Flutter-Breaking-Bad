
class Character {
  late int charId;
  late String name;
  late String nickname;
  late String image;
  late List<dynamic> jobs;
  late String status;
  late List<dynamic> breakingBadAppearance;
  late String actorName;
  late String categoryTwoSeries;
  late List<dynamic> betterCallSaulAppearance;

  Character.fromJson(Map<String, dynamic> json){
    charId = json['char_id'];
    name = json['name'];
    nickname = json['nickname'];
    image = json['img'];
    jobs = json['occupation'];
    status = json['status'];
    breakingBadAppearance = json['appearance'];
    actorName = json['portrayed'];
    categoryTwoSeries = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
  }

}