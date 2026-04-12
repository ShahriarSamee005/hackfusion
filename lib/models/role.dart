enum UserRole {
  coordinator,
  volunteer,
  boatCaptain,
  droneOperator,
  hospitalAdmin,
}

extension UserRoleExtension on UserRole {
  String get label {
    switch (this) {
      case UserRole.coordinator:    return 'Coordinator';
      case UserRole.volunteer:      return 'Volunteer';
      case UserRole.boatCaptain:    return 'Boat Captain';
      case UserRole.droneOperator:  return 'Drone Operator';
      case UserRole.hospitalAdmin:  return 'Hospital Admin';
    }
  }

  String get icon {
    switch (this) {
      case UserRole.coordinator:    return '🎯';
      case UserRole.volunteer:      return '🙋';
      case UserRole.boatCaptain:    return '⛵';
      case UserRole.droneOperator:  return '🚁';
      case UserRole.hospitalAdmin:  return '🏥';
    }
  }

  String get description {
    switch (this) {
      case UserRole.coordinator:    return 'Manage relief ops & dispatch';
      case UserRole.volunteer:      return 'Deliver supplies on ground';
      case UserRole.boatCaptain:    return 'Navigate water routes';
      case UserRole.droneOperator:  return 'Handle aerial deliveries';
      case UserRole.hospitalAdmin:  return 'Manage medical triage';
    }
  }
}