import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? _image;
  String? _base64Image;
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  double? _latitude;
  double? _longitude;
  Future<void> _pickImage(ImageSource source) async {
    final PickedFile = await _picker.pickImage(source: source);
    if (PickedFile != null) {
      setState(() {
        _image = File(PickedFile.path);
      });
      await _compressAndEncodeImage();
    }
  }

  Future<void> _compressAndEncodeImage() async {
    if(_image == null)return;
    final compressedImage = await FlutterImageCompress.compressWithFile(
      _image!.path,
      quality: 50,
    );
    if (compressedImage == null) return;
    {
      setState(() {
        _base64Image = base64Encode(compressedImage);
      });
    }
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location Services are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission == await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        throw Exception('Location Permissions are denied.');
      }
    }
    try {
      final Position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      ).timeout(const Duration(seconds: 10));
      setState(() {
        _latitude = null;
        _longitude = null;
      });
    }
    Future<void> _submitPost() async{
      if (_base64Image == null || _descriptionController.text.isEmpty)return;
      setState(() => _isUploading = true); {
        final now = DateTime.now().toIso8601String();
        final uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid == null) {
          setState(() => _isUploading=false); {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Not Found.')),);
          };
          return;
        }
        try{
          await _getLocation();
          //Ambil Nama Lengkap dari koleksi Users
          final userDoc=
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
          final fullName = userDoc.data()?['FullName']?? 'Anonymous';
          await FirebaseFirestore.instance.collection('posts').add({
            'image' : _base64Image,
            'description':_descriptionController,
            'createdAt':now,
            'latitude': _latitude,
            "longitude" : _longitude,
            'fullName' : fullName,
            'userId':uid,
          });
          if (!mounted) return; 
            Navigator.pop(context);
        }catch(e){
          debugPrint('Upload failed :$e');
          if (!mounted)return;
          setState(() => _isUploading=false); {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(context : Text('Failed to upload the post')),);
          };
        }
      void _showImageSourceDialog(){
        showDialog(context: context, builder: (context))
      }
      }; {
        
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}