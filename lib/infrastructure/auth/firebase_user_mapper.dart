import 'package:ddd_example/domain/core/value_objects.dart';

import '../../domain/auth/user.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserDomainX on User? {
  auth.User? toDomain() {
    if(this != null){
      return auth.User(id: UniqueId.fromUniqueString(this!.uid));
    }
    return null;
  }
}

const fux = "";