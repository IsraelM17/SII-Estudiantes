class Kardex{

  String qualification;
  String semester;
  Matter matter;
  Oportunity oportunity;

  Kardex({
    this.qualification,
    this.semester,
    this.matter,
    this.oportunity
  });

  factory Kardex.fromJson(Map jsonMap){
    return Kardex(
      qualification: jsonMap['qualification'],
      semester: jsonMap['semester'],
      matter: Matter.fromJson(jsonMap['matter']),
      oportunity: Oportunity.fromJsoon(jsonMap['opportunity'])
      );
  }

}

class Matter{
  String keyMatter;
  String name;

  Matter({
    this.keyMatter,
    this.name
  });

  factory Matter.fromJson(Map jsonMap){
    return Matter(
      keyMatter: jsonMap['keymatter'],
      name: jsonMap['name']
    );
  }
}

class Oportunity{
  String description;

  Oportunity({
    this.description
  });


  factory Oportunity.fromJsoon(Map jsonMap){
    return Oportunity(
      description: jsonMap['description']
    );
  }
}