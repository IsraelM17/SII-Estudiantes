class Alumnos{

  String name;
	String father_lastname;
	String mother_lastname;
	String email;
  String idstudent;
  String idgroup;

  Alumnos({
    this.name,
    this.email,
    this.father_lastname,
    this.mother_lastname,
    this.idgroup,
    this.idstudent
  });

  factory Alumnos.fromJson(Map jsonMap){
    return Alumnos(
      name: jsonMap['name'],
      father_lastname:  jsonMap['father_lastname'],
      mother_lastname: jsonMap['mother_lastname'],
      email: jsonMap['email'],
      idgroup: jsonMap['idgroup'],
      idstudent: jsonMap['idstudent']
    );
  }

}