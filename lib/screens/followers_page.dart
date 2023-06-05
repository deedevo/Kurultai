import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kurultai_app/utils/colors.dart';


class FollowersCard extends StatefulWidget {
  const FollowersCard({super.key});

  @override
  State<FollowersCard> createState() => _FollowersCardState();
}

class _FollowersCardState extends State<FollowersCard> {

  List<dynamic> followersList = []; // shouldn't use dynamic

  getdata() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      // get followerIds
      List<String> follwerIds = List.from(value.data()!['followers']);
      // loop through all ids and get associated user object by userID/followerID
      for (int i = 0; i < follwerIds.length; i++) {
        var followerId = follwerIds[i];
        var data = await FirebaseFirestore.instance
            .collection("users")
            .doc(followerId)
            .get();

        // push that data into followersList variable as we are going
        // to use that in listViewBuilder
        followersList.add(data);
      }
      setState(() {});
    });

    @override
    void initState() {
      super.initState();
      getdata();
    }
  }

  @override
  Widget build(BuildContext context) {
    // use the listView builder to render the list of followers card
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: ListView.builder(
          itemCount: followersList.length,
          itemBuilder: (context, index) {
            var followerItem = followersList[index];

            return _buildFollowersCard(followerItem['photoUrl'], followerItem['username']);
          }
      ),
    );
  }

  Widget _buildFollowersCard(String photoUrl, String username) {
    return Container(
      height: 70,
      width: double.infinity,
      color: mobileBackgroundColor,
      child: Card(
        child: Column(children: [
          //Header
          Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    photoUrl,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}