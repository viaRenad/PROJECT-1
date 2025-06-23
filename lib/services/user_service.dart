import 'package:mulabbi/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mulabbi/models/user_type.dart';
import 'package:mulabbi/models/journey.dart';

class UserService {
  static final _supabase = Supabase.instance.client;

  static Future<User?> getCurrentUser() async {
    final token = await storage.getString("token");
    if (token == null) return null;

    try {
      final response = await supabase.auth.getUser(token);

      return response.user;
    } catch (e) {
      return null;
    }
  }

  // جلب نوع المستخدم الحالي
  static Future<UserType> getCurrentUserType() async {
    try {
      final user = await getCurrentUser();

      if (user == null) {
        return UserType.guest;
      }

      final response =
          await _supabase
              .from('users')
              .select('user_type')
              .eq('id', user.id)
              .maybeSingle();

      if (response == null) {
        // إنشاء مستخدم جديد إذا لم يكن موجود
        await _createUserRecord(user);
        return UserType.user;
      }

      return UserType.values.firstWhere(
        (type) => type.name == response['user_type'],
        orElse: () => UserType.user,
      );
    } catch (e) {
      print('خطأ في جلب نوع المستخدم: $e');
      return UserType.guest;
    }
  }

  // إنشاء سجل مستخدم جديد
  static Future<void> _createUserRecord(User user) async {
    try {
      await _supabase.from('users').insert({
        'id': user.id,
        'email': user.email ?? '',
        'user_type': UserType.user.name,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('خطأ في إنشاء سجل المستخدم: $e');
    }
  }

  // تحديث نوع المستخدم
  static Future<bool> updateUserType(UserType newType) async {
    try {
      final user = await getCurrentUser();
      if (user == null) return false;

      await _supabase
          .from('users')
          .update({
            'user_type': newType.name,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', user.id);

      return true;
    } catch (e) {
      print('خطأ في تحديث نوع المستخدم: $e');
      return false;
    }
  }

  // بدء رحلة جديدة
  static Future<bool> startJourney({String title = 'رحلة جديدة'}) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return false;

      // تحديث نوع المستخدم إلى onJourney
      await updateUserType(UserType.onJourney);

      // إنشاء رحلة جديدة
      await _supabase.from('journeys').insert({
        'user_id': user.id,
        'title': title,
        'status': 'active',
        'started_at': DateTime.now().toIso8601String(),
        'created_at': DateTime.now().toIso8601String(),
      });

      return true;
    } catch (e) {
      print('خطأ في بدء الرحلة: $e');
      return false;
    }
  }

  // إنهاء الرحلة الحالية
  static Future<bool> completeJourney() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return false;

      // تحديث الرحلة النشطة
      await _supabase
          .from('journeys')
          .update({
            'status': 'completed',
            'completed_at': DateTime.now().toIso8601String(),
          })
          .eq('user_id', user.id)
          .eq('status', 'active');

      // تحديث نوع المستخدم إلى user
      await updateUserType(UserType.user);

      return true;
    } catch (e) {
      print('خطأ في إنهاء الرحلة: $e');
      return false;
    }
  }

  // جلب الرحلة النشطة
  static Future<Journey?> getActiveJourney() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return null;

      final response =
          await _supabase
              .from('journeys')
              .select()
              .eq('user_id', user.id)
              .eq('status', 'active')
              .maybeSingle();

      if (response == null) return null;

      return Journey.fromJson(response);
    } catch (e) {
      print('خطأ في جلب الرحلة النشطة: $e');
      return null;
    }
  }

  // الاستماع لتغييرات المستخدم
  static Stream<UserType> getUserTypeStream() async* {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      yield UserType.guest;
      return;
    }

    yield* _supabase
        .from('users')
        .stream(primaryKey: ['id'])
        .eq('id', user.id)
        .map((data) {
          if (data.isEmpty) return UserType.guest;

          final userData = data.first;
          return UserType.values.firstWhere(
            (type) => type.name == userData['user_type'],
            orElse: () => UserType.user,
          );
        });
  }

  static Future<void> registerFirstTime() async {
    await storage.setBool("isFirstTime", false);
  }
}
