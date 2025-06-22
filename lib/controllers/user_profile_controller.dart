import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfileController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _supabase = Supabase.instance.client;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Load user data when entering the page
  Future<void> loadUserData() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final user = _supabase.auth.currentUser;
      if (user == null) {
        _errorMessage = 'لم يتم العثور على المستخدم';
        return;
      }

      // Get user data from Supabase
      final response =
          await _supabase
              .from('users')
              .select('name, email')
              .eq('id', user.id)
              .maybeSingle();

      if (response != null) {
        nameController.text = response['name'] ?? '';
        emailController.text = response['email'] ?? user.email ?? '';
      } else {
        // If no user record exists, use auth user data
        emailController.text = user.email ?? '';
      }
    } catch (e) {
      _errorMessage = 'خطأ في تحميل بيانات المستخدم: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Save user profile changes
  Future<bool> saveUserProfile() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final user = _supabase.auth.currentUser;
      if (user == null) {
        _errorMessage = 'لم يتم العثور على المستخدم';
        return false;
      }

      // Update user data in Supabase
      await _supabase.from('users').upsert({
        'id': user.id,
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'updated_at': DateTime.now().toIso8601String(),
      });

      // Update email in auth if changed
      if (emailController.text.trim() != user.email) {
        await _supabase.auth.updateUser(
          UserAttributes(email: emailController.text.trim()),
        );
      }

      // Update password if provided
      if (passwordController.text.isNotEmpty) {
        await _supabase.auth.updateUser(
          UserAttributes(password: passwordController.text),
        );
        passwordController.clear();
      }

      return true;
    } catch (e) {
      _errorMessage = 'خطأ في حفظ البيانات: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
