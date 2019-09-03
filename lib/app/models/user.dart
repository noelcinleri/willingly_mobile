import 'package:flutter/widgets.dart';
import 'package:willingly/app/utils/utils.dart';

class User {
  int id;
  String name;
  String photo;
  String location = 'Istanbul, Turkiye';
  String gender;
  int age;
  String about;
  User(this.id, this.name, this.photo, this.gender, this.age,this.about);
}

// Names generated at http://random-name-generator.info/
List<User> users = [
  User(1, 'Umut YILDIRIM', AvailableImages.emptyProfilePicture['assetPath'], 'M', 27,'hakkında'),
  User(2, 'Maria Perez', AvailableImages.woman1['assetPath'], 'F', 24,'hakkında'),
  User(3, 'Craig Jordan', AvailableImages.man2['assetPath'], 'M', 28,'hakkında'),
  User(4, 'Charlotte Mckenzie', AvailableImages.woman2['assetPath'], 'F', 23,'hakkında'),
  User(5, 'Rita Pena', AvailableImages.woman3['assetPath'], 'F', 25,'hakkında'),
  User(6, 'Robin Mcguire', AvailableImages.man3['assetPath'], 'M', 29,'hakkında'),
  User(7, 'Angelina Love', AvailableImages.woman4['assetPath'], 'F', 22,'hakkında'),
  User(8, 'Louis Diaz', AvailableImages.man4['assetPath'], 'M', 23,'hakkında'),
  User(9, 'Kyle Poole', AvailableImages.man5['assetPath'], 'M', 25,'hakkında'),
  User(10, 'Brenda Watkins', AvailableImages.woman5['assetPath'], 'F', 26,'hakkında'),
];

List<String> userHobbies = [
  "Dancing", "Hiking", "Singing", "ala32", "Fishing"
]; 
