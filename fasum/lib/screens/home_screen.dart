import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasum/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inSeconds < 60) {
      return '${diff.inSeconds} secs ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} mins ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hrs ago';
    } else {
      return DateFormat('dd/mm/yyyy').format(dateTime);
    }
  }

  Future<void> signOut(BuildContext context)async{
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context)=> SignInScreen())
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  const Text("Home"),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      actions: [
        IconButton(onPressed: (){
          signOut(context);
        }, icon: const Icon(Icons.logout),
        ),
      ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts")
        //.orderBy("created", descending: true)
        .snapshots(), 
        builder: (context, snapshots){
          if (snapshots.hasData) return Center(child: CircularProgressIndicator());

          final posts = snapshots.data!.docs;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index){
              final data = posts[index].data();
              final imageBase64 = data["image"];
              final description = data["description"];
              //final createdAtStr = data["createdAt"];
              final fullName = data["fullName"] ?? 'Anonim';

              //final createdAt = DateTime.parse(createdAtStr);
              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      description ?? '',
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    )
                  ],
                ),
              );
            }
          );
        }
      ),
    );
  }
}