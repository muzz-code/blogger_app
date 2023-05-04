import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/blog.dart';
import '../provider/blog_provider.dart';

class EditBlogScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditBlogScreenState createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<EditBlogScreen> {
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
        title: Text('Edit Blog'),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onSaved: (value) {
                          _editedBlog = Blog(
                              name: _editedBlog.name,
                              imageUrl: value!,
                              id: '',
                              description: _editedBlog.description,
                              title: _editedBlog.title);
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter a value';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
