import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference _userCollection =
      Firestore.instance.collection('user');

  Future updateUser(String id, String name) async {
    return await _userCollection
        .document(uid)
        .setData({'uid': id, 'name': name});
  }

  List<User> _userList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(uid: doc.data['uid'] ?? '', name: doc.data['name'] ?? '');
    }).toList();
  }

  Stream<List<User>> get users {
    return _userCollection.snapshots().map(_userList);
  }
}
