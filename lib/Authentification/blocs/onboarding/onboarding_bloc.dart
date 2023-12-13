import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginbloc/Authentification/repositories/database/database_repository.dart';
import 'package:loginbloc/Authentification/repositories/storage/storage_repository.dart';
import 'package:loginbloc/user_model.dart';
part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final DatabaseRepository _databaseRepository;
  final StorageRepository _storageRepository;

  OnboardingBloc({
    required DatabaseRepository databaseRepository,
    required StorageRepository storageRepository,
  })  : _databaseRepository = databaseRepository,
        _storageRepository = storageRepository,
        super(OnboardingLoading()) {
    on<StartOnboarding>(_onStartOnboarding);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateUserImages>(_onUpdateUserImages);
  }

  void _onStartOnboarding(
    StartOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    await _databaseRepository.createUser(event.user);
    emit(OnboardingLoaded(user: event.user));
  }

  void _onUpdateUser(
    UpdateUser event,
    Emitter<OnboardingState> emit,
  ) {
    if (state is OnboardingLoaded) {
      _databaseRepository.updateUser(event.user);
      emit(OnboardingLoaded(user: event.user));
    }
  }

void _onUpdateUserImages(
  UpdateUserImages event,
  Emitter<OnboardingState> emit,
) async {
  if (state is OnboardingLoaded) {
    User user = (state as OnboardingLoaded).user;
       
    print('Image file path: ${event.image.path}');
    await _storageRepository.uploadImage(user, event.image);

    // After image upload is completed, get the download URL
    String downloadUrl = await _storageRepository.getDownloadURL(user, event.image.name);

    // Update the user's photoUrl field
    user = user.copyWith(photoUrl: downloadUrl);

    // Update the user in Firestore database
    _databaseRepository.updateUser(user);

    // Emit the updated state
    emit(OnboardingLoaded(user: user));
  }
}

}
