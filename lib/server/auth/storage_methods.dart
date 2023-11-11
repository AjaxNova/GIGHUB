import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadimageToDb(
      {required String uid,
      required String childname,
      required Uint8List file,
      required bool isJobimagePost,
      bool isUpdate = false}) async {
    Reference ref = _storage.ref().child(childname).child(uid);
    if (isUpdate) {
      await ref.delete();
    }

    if (isJobimagePost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask task = ref.putData(file);
    TaskSnapshot snap = await task;

    String url = await snap.ref.getDownloadURL();
    return url;
  }
}
