import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class AnimalBloc extends BlocBase {
  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();

  Stream<Map> get outData => _dataController.stream;

  Stream<bool> get outLoading => _loadingController.stream;

  DocumentSnapshot animal;

  Map<String, dynamic> unsavedData;

  AnimalBloc({this.animal}) {
    if (animal != null) {
      unsavedData = Map.of(animal.data);
      unsavedData['images'] = List.of(animal.data['images']);
    } else {
      unsavedData = {
        "images": [],
        "name": null,
        "porte": null,
        "description": null,
        "phone": null,
        "userId": null,
        "date": null,
      };
    }
    _dataController.add(unsavedData);
  }

  void saveImages(List images) {
    unsavedData["images"] = images;
  }

  void saveName(String name) {
    unsavedData["name"] = name;
  }

  void savePorte(String porte) {
    unsavedData["porte"] = porte;
  }

  void saveDescription(String description) {
    unsavedData["description"] = description;
  }

  void savePhone(String phone) {
    unsavedData["phone"] = phone;
  }

  void saveUserId(String userId) {
    unsavedData["userId"] = userId;
  }
  void saveDate(DateTime date) {
    unsavedData["date"] = date;
  }



  Future<bool> saveAnimal() async {
    _loadingController.add(true);

    try {
      if (animal != null) {
        await _uploadImages(animal.documentID);
        await animal.reference.updateData(unsavedData);
      } else {
        DocumentReference dr = await Firestore.instance
            .collection("animals")
            .add(Map.from(unsavedData)..remove("images"));
        await _uploadImages(dr.documentID);
        await dr.updateData(unsavedData);
      }

      _loadingController.add(false);
      return true;
    } catch (e) {
      _loadingController.add(false);
      return false;
    }
  }

  Future _uploadImages(String animalId) async {
    for (int i = 0; i < unsavedData["images"].length; i++) {
      if (unsavedData["images"][i] is String) continue;

      StorageUploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(animalId)
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(unsavedData["images"][i]);

      StorageTaskSnapshot s = await uploadTask.onComplete;
      String downloadUrl = await s.ref.getDownloadURL();

      unsavedData["images"][i] = downloadUrl;
    }
  }


  @override
  void dispose() {
    _dataController.close();
    _loadingController.close();
  }
}
