class TeacherGroup{

  String keymatter;
	String name;
	String idteacher;

  TeacherGroup({
    this.keymatter,
    this.name,
    this.idteacher
  });

  factory TeacherGroup.fromJson(Map jsonMap){
    return TeacherGroup(
      keymatter: jsonMap['keymatter'],
      name: jsonMap['name'],
      idteacher: jsonMap['idteacher']
    );
  }

}