import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posttest/Providers/Post_Provider.dart';
import 'package:posttest/Ui/Add_New_Post.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    Future.microtask(() => context.read<PostProvider>().getPosts(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postData = context.watch<PostProvider>();
    return Scaffold(
        floatingActionButton: postData.postData.length > 0
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                      context, AnimatedSizeRoute(page: AddNewPost()));
                },
                label: Text("Add New Post"))
            : SizedBox.shrink(),
        appBar: AppBar(
          title: Text("Json post"),
        ),
        body: RefreshIndicator(
            onRefresh: () => context.read<PostProvider>().onRefresh(context),
            child: postData.postData.length > 0
                ? ListView.builder(
                    itemCount: postData.postData.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              context
                                  .read<PostProvider>()
                                  .deletePosts(Index: index);
                            }
                          },
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black38, blurRadius: 8)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    postData.postData[index].title.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    postData.postData[index].body.toString(),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ));
                    },
                  )
                : Center(child: CupertinoActivityIndicator())));
  }
}

class AnimatedSizeRoute extends PageRouteBuilder {
  final Widget page;
  AnimatedSizeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          ),
        );
}
