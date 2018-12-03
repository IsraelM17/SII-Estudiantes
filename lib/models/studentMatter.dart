class StudentMatter{

  String keyMatter;
  String semester;
  String idgroup;
  String idteacher;
  String name;

  StudentMatter({
    this.keyMatter,
    this.semester,
    this.idgroup,
    this.idteacher,
    this.name
  });

  factory StudentMatter.fromJson(Map jsonMap){
    return StudentMatter(
      keyMatter: jsonMap["keymatter"],
      name: jsonMap["name"],
      semester: jsonMap["semester"],
      idgroup:  jsonMap["idgroup"],
      idteacher: jsonMap["idteacher"]
    );
  }

}