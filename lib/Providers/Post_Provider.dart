import 'package:flutter/material.dart';
import 'package:posttest/Models/PostModel.dart';
import 'package:posttest/Network/ApiProvider.dart';
import 'package:posttest/Ui/CommonWidgets/CommonWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostProvider extends ChangeNotifier {
  ApiProvider _apiProvider = ApiProvider();

  List<PostModel> _postData = [];
  List<PostModel> get postData => this._postData;

  Future<Null> getPosts(context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (await _apiProvider.getConnectivityStatus()) {
      final response = await _apiProvider.get('/posts');
      if (response != null) {
        var data = response as List;
        _postData = data.map((obj) => PostModel.fromJson(obj)).toList();
        _prefs.clear();
        final String encodedData = PostModel.encode(_postData);
        _prefs.setString("postData", encodedData);
        notifyListeners();
      }
    } else {
      String? rawData = await _prefs.getString("postData");
      if (rawData != null) {
        final List<PostModel> postModel = PostModel.decode(rawData);
        print(postModel);
        _postData = postModel;
        notifyListeners();
      }
      CustomSnackBar(context, Text("No Internet connection"));
    }
  }

  void deletePosts({required int Index}) {
    _postData.removeAt(Index);
    notifyListeners();
  }

  Future<void> addPost({required PostModel postData}) async {
    _postData.add(postData);
    notifyListeners();
  }

  Future<void> onRefresh(context) async {
    getPosts(context);
  }
}
