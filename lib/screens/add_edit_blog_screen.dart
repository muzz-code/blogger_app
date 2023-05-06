import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../widgets/image_picker.dart';

import '../provider/blog.dart';
import '../provider/blog_provider.dart';

class EditBlogScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditBlogScreenState createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<EditBlogScreen> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('failed to pick image: $e');
    }
  }

  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedBlog =
      Blog(id: '', name: '', title: '', description: '', imageUrl: '');

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    Provider.of<Blogs>(context, listen: false).addBlog(_editedBlog);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _descriptionFocusNode.dispose();
    _titleFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Blog'),
        actions: <Widget>[
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                imageProfile(),
                TextFormField(
                  decoration: InputDecoration(labelText: 'name'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _editedBlog = Blog(
                        name: value!,
                        imageUrl: _editedBlog.imageUrl,
                        id: '',
                        description: _editedBlog.description,
                        title: _editedBlog.title);
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_titleFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'topic'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _descriptionFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) {
                    _editedBlog = Blog(
                        name: _editedBlog.name,
                        imageUrl: _editedBlog.imageUrl,
                        id: '',
                        description: _editedBlog.description,
                        title: value!);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    _editedBlog = Blog(
                        name: _editedBlog.name,
                        imageUrl: _editedBlog.imageUrl,
                        id: '',
                        description: value!,
                        title: _editedBlog.title);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter a value';
                    }
                    return null;
                  },
                ),
              ],
            )),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        const CircleAvatar(
            radius: 80.0,
            backgroundImage: AssetImage("assets/images/tiger.jpeg")
            // image == null
            //     ? AssetImage("assets/tiger.jpeg")
            //     : FileImage(File(_imageFile.path)),
            ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                pickImage(ImageSource.camera);
              },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                pickImage(ImageSource.gallery);
              },
              label: const Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }
}
