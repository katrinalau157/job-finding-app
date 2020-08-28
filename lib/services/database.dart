import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addUserFav(String email, String favID, favData) {
    Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((value) {
        Firestore.instance
            .collection("users")
            .document(value.documentID)
            .collection("fav")
            .document(favID)
            .setData(favData)
            .catchError((e) {
          print(e.toString());
        });
      });
    });
  }

  getUserFavJob(String email) {
    return Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((value) {
        Firestore.instance
            .collection("users")
            .document(value.documentID)
            .collection("fav")
            .getDocuments();
      });
    });
  }

  deleteUserFav(String email, String jobDocId) {
    Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((value) {
        Firestore.instance
            .collection("users")
            .document(value.documentID)
            .collection("fav")
            .document(jobDocId)
            .delete()
            .then((_) {
          print("success!");
        });
      });
    });
  }

  getfavJobPost(String docId) {
    Firestore.instance
        .collection("JobPost")
        .document(docId)
        .get()
        .then((value) {
      print(value.data);
    });
  }

  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('name', isEqualTo: searchField)
        .getDocuments();
  }

  Future<bool> createChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection("users").add(userMap);
  }

  getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return await Firestore.instance
        .collection("ChatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

}
