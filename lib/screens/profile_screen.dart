import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';
import '../models/chat_user.dart';



class ProfileScreen extends StatefulWidget {

  final ChatUser user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gupshup'),
      ),
      body:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: mq.width * 0.05),
        child: Column(
          children: [
            SizedBox(width: mq.width, height: mq.height*.03 ),
            ClipRRect(
    borderRadius: BorderRadius.circular(mq.height*.1),
            child: CachedNetworkImage(
            height: mq.height * 0.2,
            width: mq.height* 0.2,
            fit: BoxFit.fill,
            imageUrl: widget.user.image,
            // placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person_alt),
            ),),
            ),

            SizedBox( height: mq.height*.03 ),
            Text(widget.user.email, style: TextStyle(color: Colors.black54, fontSize: 16),),
            SizedBox( height: mq.height*.05 ),

            // for name field
            TextFormField(initialValue: widget.user.name, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: Icon(Icons.person, color: Colors.blue,),
              hintText: "Enter your name",
              label: Text("Name"),
            ),),
            //for about field

            SizedBox( height: mq.height*.03 ),

            TextFormField(initialValue: 'Hey, I am using Gupshup !', decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              prefixIcon: Icon(Icons.info_outline, color: Colors.blue,),
              hintText: "Tell about yourself.",
              label: Text("About"),
            ),),
            SizedBox( height: mq.height*.03 ),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(shape: StadiumBorder(), minimumSize: Size(mq.width* .4, mq.height*.05)),
              onPressed: (){}, icon:Icon(Icons.edit) ,  label: Text("UPDATE", style: TextStyle(fontSize: 18),),)

          ],
        ),
      ),
      // drawer: Drawer(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 15, right: 10),
        child: FloatingActionButton.extended(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
          },
            icon: Icon(Icons.logout),
            label: Text("Logout"),
        ),

      ),

    );
  }
}
