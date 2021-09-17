import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:make_ten_billion/helpers/validator.dart';
import 'package:make_ten_billion/notification/notification_service.dart';
import 'package:make_ten_billion/widgets/widgets.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('알림메시지 발송', style: TextStyle(fontFamily: 'Binggrae')),
        backgroundColor: Colors.black,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Center(
            child: Column(
              children: [
                FormInputFieldWithIcon(
                  controller: titleController,
                  iconPrefix: Icons.title,
                  labelText: '제목',
                  validator: Validator().name,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                  titleController.text = value!,
                ),
                FormVerticalSpace(),
                FormInputFieldWithIcon(
                  controller: contentController,
                  iconPrefix: Icons.description,
                  labelText: '알림내용',
                  validator: Validator().name,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                  contentController.text = value!,
                ),
                FormVerticalSpace(),

                PrimaryButton(
                    labelText: '발송하기',
                    buttonColor: Colors.blueAccent,
                    onPressed: () async {
                      // if (_formKey.currentState!.validate()) {
                      SystemChannels.textInput.invokeMethod(
                          'TextInput.hide'); //to hide the keyboard - if any
                      NotificationService().sendMessage(titleController.text, contentController.text, imgUrl: '');
                      // }
                      Get.back();
                    }),
              ],
            )
          )
        ),
      )
    );
  }
}
