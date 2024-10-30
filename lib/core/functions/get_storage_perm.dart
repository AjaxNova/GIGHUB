import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future getStoragePermission(ImageSource source) async {
  if (await Permission.storage.request().isGranted) {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    } else {
      return;
    }
  } else if (await Permission.storage.request().isPermanentlyDenied) {
    throw 'Permission is Denied Permanently';
  } else if (await Permission.storage.request().isDenied) {
    throw 'Permission is Denied';
  }
}
