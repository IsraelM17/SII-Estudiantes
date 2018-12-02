import 'dart:io';
import 'package:sii_patm/utils/settings.dart';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class SendMail{

  main(String from, String subjectt, String content) async {
    
    String username = Settings.noControl+"@itcelaya.edu.mx";
    String password = Settings.passwordStudent;

    final smtpServer = gmail(username, password);
    
    // Create our message.
    final message = new Message()
      ..from = new Address(username, username)
      ..recipients.add(from)  
      ..subject = subjectt
      ..text = content
      ..html = "<h1></h1>\n<p>"+content+"</p>";
    
    print(from+" -- "+subjectt+" -- "+content);
    print(username+" -- "+password);
    final sendReports = await send(message, smtpServer);
  }

}