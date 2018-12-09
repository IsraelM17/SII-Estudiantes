class Student{

  int idstudent;
  String  name;
  String  father_lastname;
  String  mother_lastname;
  String  email;
  String  nocontrol;
  int     idcareer;
  String image;
  String career;
  String phone;
  String address;
  String semester;

  Student({
    this.idstudent,
    this.name,
    this.father_lastname,
    this.mother_lastname,
    this.email,
    this.nocontrol,
    this.idcareer,
    this.image,
    this.career,
    this.address,
    this.phone,
    this.semester
  });

  factory Student.fromJson(Map parsedJson){
    return Student(
      name: parsedJson['name'],
      father_lastname: parsedJson['father_lastname'],
      mother_lastname: parsedJson['mother_lastname'],
      email: parsedJson['email'],
      nocontrol: parsedJson['nocontrol'],
      career: parsedJson['nameCareer'],
      address: parsedJson['address'],
      phone: parsedJson['phone'],
      semester: parsedJson['semester']
    );
  }

}
