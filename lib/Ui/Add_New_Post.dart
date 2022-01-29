import 'package:flutter/material.dart';
import 'package:posttest/Models/PostModel.dart';
import 'package:posttest/Providers/Post_Provider.dart';
import 'package:posttest/Ui/CommonWidgets/CommonWidget.dart';
import 'package:provider/src/provider.dart';

class AddNewPost extends StatefulWidget {
  const AddNewPost({Key? key}) : super(key: key);

  @override
  _AddNewPostState createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            //color: Colors.amber,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 8)
                      ]),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Add Title';
                      }
                    },
                    controller: _titleController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: " Title here",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 8)
                      ]),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Add Body';
                      }
                    },
                    controller: _bodyController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: " Body here",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  width: 152,
                  height: 52,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      var postData = PostModel(
                          id: 1,
                          userId: 1,
                          title: _titleController.text,
                          body: _bodyController.text);
                      context
                          .read<PostProvider>()
                          .addPost(postData: postData)
                          .whenComplete(() => Navigator.pop(context))
                          .whenComplete(() => CustomSnackBar(
                              context, Text("Post Added at bottom")));
                    }
                  },
                  borderRadius: BorderRadius.circular(26),
                  elevation: 0,
                  child: Text(
                    "Submit Post",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.cyan.shade600,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
