import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/university_model.dart';

class FirestoreService {
  final CollectionReference _universitiesCollection =
      FirebaseFirestore.instance.collection('universidades');

  // Obtener flujo de universidades en tiempo real
  Stream<List<University>> getUniversities() {
    return _universitiesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => University.fromFirestore(doc)).toList();
    });
  }

  // Agregar una nueva universidad
  Future<void> addUniversity(University university) {
    return _universitiesCollection.add(university.toFirestore());
  }

  // Eliminar una universidad
  Future<void> deleteUniversity(String id) {
    return _universitiesCollection.doc(id).delete();
  }

  // Actualizar una universidad
  Future<void> updateUniversity(String id, University university) {
    return _universitiesCollection.doc(id).update(university.toFirestore());
  }
}
