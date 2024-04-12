import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class ProfilePic extends StatefulWidget {
  final String profileImageUrl;

  const ProfilePic({
    Key? key,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final ImagePicker _imagePicker = ImagePicker();
  late String _imageUrl;

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.profileImageUrl;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String imageName = 'profile_image_$userId.jpg';
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(imageName);

      try {
        await storageRef.putFile(imageFile);
        String imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'profileImage': imageUrl,
        });

        setState(() {
          _imageUrl = imageUrl;
        });
      } catch (error) {
        print('Error uploading image: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage:
                _imageUrl.isNotEmpty ? NetworkImage(_imageUrl) : null,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: _pickImage,
                child: const Icon(Icons.camera_alt_outlined),
              ),
            ),
          )
        ],
      ),
    );
  }
}
