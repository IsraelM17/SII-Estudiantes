class Student{

  int idstudent;
  String  name;
  String  father_lastname;
  String  mother_lastname;
  String  email;
  String  nocontrol;
  int     idcareer;
  String image;

  Student({
    this.idstudent,
    this.name,
    this.father_lastname,
    this.mother_lastname,
    this.email,
    this.nocontrol,
    this.idcareer,
    this.image,
  });

  factory Student.fromJson(Map parsedJson){
    return Student(
      name: parsedJson['name'],
      father_lastname: parsedJson['father_lastname'],
      mother_lastname: parsedJson['mother_lastname'],
      email: parsedJson['email'],
      nocontrol: parsedJson['nocontrol'],
    );
  }

}