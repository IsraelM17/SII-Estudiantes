class Lista{

  String c1, c2, c3, c4;
  String idstudent;
  String idgroup;
  String periodo;
  Grupo grupo;
  //Teacher teacher;

  Lista({
    this.idgroup,
    this.c1,
    this.c2,
    this.c3,
    this.c4,
    this.periodo,
    this.grupo,
    //this.teacher
  });

  
  factory Lista.fromJson(Map parsedJson){
    return Lista(
      periodo: parsedJson['periodo'],
      c1: parsedJson['c1'],
      c2: parsedJson['c2'],
      c3: parsedJson['c3'],
      c4: parsedJson['c4'],
      idgroup: parsedJson['idgroup'],
      grupo: Grupo.fromJson(parsedJson['group']),
      //teacher: Teacher.fromJson(parsedJson['teacher'])
    );
  }
  /*
  factory Lista(Map jsonMap){
    return new Lista.deserialized(jsonMap);
  }

  Lista.deserialized(Map json) :
    periodo = json["periodo"];
    //grupo = Grupo.deserialized(json); 
  */
}

class Grupo{
  String idgroup;
  Materia materia;
  Teacher teacher;
  
  Grupo({
    this.idgroup,
    this.materia,
    this.teacher
  });
  factory Grupo.fromJson(Map parsedJson){
    return Grupo(
      idgroup: parsedJson['idGroup'],
      materia: Materia.fromJson(parsedJson['matter']),
      teacher: Teacher.fromJson(parsedJson['teacher'])
    );
  }
  
  /*
  factory Grupo(Map jsonMap){
    return new Grupo.deserialized(jsonMap);
  }

  Grupo.deserialized(Map json) :
    idgroup = json["idGroup"].toInt();
  */
}

class Teacher{
  String name;
  String father_lastname;
  String mmother_lastname;
  String email;

  Teacher({
    this.name,
    this.father_lastname,
    this.mmother_lastname,
    this.email
  });

  factory Teacher.fromJson(Map json){
    return Teacher(
      name: json['name'],
      father_lastname: json['father_lastname'],
      mmother_lastname: json['mother_lastname'],
      email: json['email']
    );
  }

}

class Materia{
  String name;

  Materia({
    this.name,
  });

  factory Materia.fromJson(Map json){
    return Materia(
      name: json['name']
    );
  }

}
