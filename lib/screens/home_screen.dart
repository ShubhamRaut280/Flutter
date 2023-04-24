
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talk/screens/profile_screen.dart';
import '../api/APIs.dart';
import '../models/chat_user.dart';
import '../widgets/chat_user_card.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    var list = [];

    return Scaffold(

    appBar: AppBar(
        title: Text('Gupshup'),
        leading: Icon(CupertinoIcons.house_fill),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(user: list[0],)));
          }, icon: Icon(CupertinoIcons.person_crop_circle),)
        ],
      ),
      // drawer: Drawer(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 15, right: 10),
        child: FloatingActionButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
          },
          child: Icon(Icons.add_comment_rounded),
        ),
      ),
      body: StreamBuilder(
          stream: APIs.firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              // if data is loading
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(child: const CircularProgressIndicator());

              // if some or all data is loaded then show it
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                ;
                list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                    [];

                if(list.isNotEmpty)
                  {
                    return ListView.builder(
                        itemCount: list.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ChatUserCard(
                            user: list[index],
                          );
                          // return Text('Name: ${list[index]}');
                        });
                  }else
                    {
                        return Center(child: Text('No connection found', style: TextStyle(fontSize: 20),));
                    }


            }
            ;
          }),
    );
  }
}
