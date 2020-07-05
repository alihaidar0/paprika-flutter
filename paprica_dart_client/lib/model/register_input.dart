part of swagger.api;

class RegisterInput {
  
  String name = null;
  

  String surname = null;
  

  String userName = null;
  

  String emailAddress = null;
  

  String password = null;
  

  String captchaResponse = null;
  
  RegisterInput();

  @override
  String toString() {
    return 'RegisterInput[name=$name, surname=$surname, userName=$userName, emailAddress=$emailAddress, password=$password, captchaResponse=$captchaResponse, ]';
  }

  RegisterInput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
    surname =
        json['surname']
    ;
    userName =
        json['userName']
    ;
    emailAddress =
        json['emailAddress']
    ;
    password =
        json['password']
    ;
    captchaResponse =
        json['captchaResponse']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'userName': userName,
      'emailAddress': emailAddress,
      'password': password,
      'captchaResponse': captchaResponse
     };
  }

  static List<RegisterInput> listFromJson(List<dynamic> json) {
    return json == null ? new List<RegisterInput>() : json.map((value) => new RegisterInput.fromJson(value)).toList();
  }

  static Map<String, RegisterInput> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RegisterInput>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RegisterInput.fromJson(value));
    }
    return map;
  }
}

