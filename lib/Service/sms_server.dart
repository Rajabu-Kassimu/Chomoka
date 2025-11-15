import 'package:flutter_sms/flutter_sms.dart';

class SmsService {
  List<String> recipents;
  String message;

  SmsService(this.recipents, this.message);

  sendSms() async {
    String _result =
        await sendSMS(message: message, recipients: recipents, sendDirect: true)
            .catchError((onError) {
      return false;
    });

    return _result;
  }
}
