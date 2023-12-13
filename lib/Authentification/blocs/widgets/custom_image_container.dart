import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../onboarding/onboarding_bloc.dart';

class CustomImageContainer extends StatelessWidget {
  const CustomImageContainer({
    Key? key,
    this.photoUrl,
        required this.onImageSelected, // Receive the callback function
  }) : super(key: key);

  final String? photoUrl;
  final Function(XFile) onImageSelected; // Define the callback function
  @override
 Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: SizedBox(
        height: 150,
        width: 150,
        child: Stack(
          children: [
            (photoUrl == null)
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 64,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                  )
                : ClipOval(
                    child: Image.file(
                      File(photoUrl!),
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
                  ),
            Positioned(
              bottom: 0,
              left: 80,
              child: IconButton(
                icon: const Icon(
                  Icons.add_a_photo,
                ),
                onPressed: () async {
                  ImagePicker _picker = ImagePicker();
                  final XFile? _image = await _picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 50,
                  );

                  if (_image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No image was selected.')),
                    );
                  }

                  if (_image != null) {
                    print('Uploading ...');
                    onImageSelected(_image); // Call the callback function
                    BlocProvider.of<OnboardingBloc>(context).add(
                      UpdateUserImages(image: _image,
                      photoUrl: photoUrl),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



