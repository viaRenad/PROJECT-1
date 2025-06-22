enum UserType {
  guest,
  user,
  onJourney;

  String get displayName {
    switch (this) {
      case UserType.guest:
        return 'زائر';
      case UserType.user:
        return 'مستخدم';
      case UserType.onJourney:
        return 'في رحلة';
    }
  }
}
