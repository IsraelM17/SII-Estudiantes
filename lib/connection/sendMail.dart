import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class SendMail{
  main() async {
    String username = '14030625@itcelaya.edu.mx';
    String password = 'santiago1105.';

    final smtpServer = gmail(username, password);
    
    // Create our message.
    final message = new Message()
      ..from = new Address(username, 'Your name')
      ..recipients.add('se.israel.mc@gmail.com')  
      ..subject = 'Test Dart Mailer library :: 😀 :: ${new DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
    
    final sendReports = await send(message, smtpServer);
  }

}