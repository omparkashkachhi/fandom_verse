import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Auth Streams
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Firestore Fetch Methods
  Stream<QuerySnapshot> getFandomsStream() {
    return _firestore.collection('fandoms').snapshots();
  }

  Stream<QuerySnapshot> getEventsStream() {
    return _firestore.collection('events').snapshots();
  }

  Stream<QuerySnapshot> getProductsStream() {
    return _firestore.collection('products').snapshots();
  }
}