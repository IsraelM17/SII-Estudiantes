class Teacher{

  String  idteacher;
  String  name;
  String  father_lastname;
  String  mother_lastname;
  String  email;
  String  nocontrol;
  String 	address;
  String 	phone;

  Teacher({
    this.idteacher,
    this.name,
    this.father_lastname,
    this.mother_lastname,
    this.email,
    this.nocontrol,
    this.address,
    this.phone
  });

  factory Teacher.fromJson(Map jsonMap){
    return Teacher(
      idteacher: jsonMap['idteacher'],
      name: jsonMap['name'],
      father_lastname: jsonMap['father_lastname'],
      mother_lastname: jsonMap['mother_lastname'],
      email: jsonMap['email'],
      nocontrol: jsonMap['nocontrol'],
      address: jsonMap['address'],
      phone: jsonMap['phone']
    );
  }

}