import 'package:flutter/material.dart';
import 'package:quiz_app/models/feed.dart';
import 'package:quiz_app/services/fileService.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<Feed> feeds = [];
  @override
  void initState() {
    super.initState();
    loadDataForScreen();
  }

  bool isLoading = true;

  loadDataForScreen() async {
    setState(() {
      isLoading = true;
    });
    feeds = await FileService.getallfeed();
    print(feeds[0].toJson());
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          "Feed",
          style: Theme.of(context)
              .primaryTextTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.46),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
            padding: EdgeInsets.only(top:16, left: 8, right: 8),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: feeds.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  print(feeds[index].createdAt.difference(DateTime.now()).inDays);
                  return Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: feeds[index].createdAt.difference(DateTime.now()).inDays >= 0 ? Icon(Icons.file_present): Icon(Icons.new_releases),
                        title: Text(feeds[index].name),
                        trailing: IconButton(
                          icon: Icon(Icons.download_rounded, color: Colors.black,),
                          onPressed: () async {
                            if (await canLaunch(feeds[index].fileUrl)) {
                              await launch(feeds[index].fileUrl);
                            } else {
                              print('Could not launch ${feeds[index].fileUrl}');
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
