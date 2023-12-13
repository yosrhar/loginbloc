part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class StartOnboarding extends OnboardingEvent {
  final User user;

  static final defaultUser = User.defaultUser(); // Constant defaultUser

  StartOnboarding({
    User? user,
  }) : user = user ?? defaultUser;

  @override
  List<Object?> get props => [user];
}

class UpdateUser extends OnboardingEvent {
  final User user;

  const UpdateUser({required this.user});

  @override
  List<Object?> get props => [user];
}

class UpdateUserImages extends OnboardingEvent {
  final User? user;
  final XFile image;
  final String? photoUrl;
  const UpdateUserImages({
    this.user,
    required this.image,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [user, image];
}
