import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/game.dart';
import '../shared/dialog_utils.dart';
import 'games_manager.dart';

class EditAddGameScreen extends StatefulWidget {
  static const routeName = '/add_edit_product';

  EditAddGameScreen(Game? game, {super.key}) {
    if (game == null) {
      this.game = Game(
        id: null,
        name: '',
        releaseDate: '',
        developer: '',
        publisher: '',
        category: '',
        price: 0,
        imageUrl: '',
        description: '',
      );
    } else {
      this.game = game;
    }
  }

  late final Game game;

  @override
  State<EditAddGameScreen> createState() => _EditAddGameScreenState();
}

class _EditAddGameScreenState extends State<EditAddGameScreen> {
  final _editForm = GlobalKey<FormState>();
  late Game _editedGame;

  @override
  void initState() {
    _editedGame = widget.game;
    super.initState();
  }

  TextFormField _buildNameField() {
    return TextFormField(
      initialValue: _editedGame.name,
      decoration: const InputDecoration(labelText: 'Game Name'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedGame = _editedGame.copyWith(name: value);
      },
    );
  }

  TextFormField _buildReleaseDateField() {
    return TextFormField(
      initialValue: _editedGame.releaseDate,
      decoration:
          const InputDecoration(labelText: 'Game Release Date (DD/MM/YYYY)'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedGame = _editedGame.copyWith(releaseDate: value);
      },
    );
  }

  TextFormField _buildDeveloperField() {
    return TextFormField(
      initialValue: _editedGame.developer,
      decoration: const InputDecoration(labelText: 'Game Developer'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedGame = _editedGame.copyWith(developer: value);
      },
    );
  }

  TextFormField _buildPublisherField() {
    return TextFormField(
      initialValue: _editedGame.publisher,
      decoration: const InputDecoration(labelText: 'Game Publisher'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedGame = _editedGame.copyWith(publisher: value);
      },
    );
  }

  TextFormField _buildCategoryField() {
    return TextFormField(
      initialValue: _editedGame.category,
      decoration: const InputDecoration(labelText: 'Game Category'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedGame = _editedGame.copyWith(category: value);
      },
    );
  }

  TextFormField _buildPriceField() {
    return TextFormField(
      initialValue: _editedGame.price.toString(),
      decoration: const InputDecoration(labelText: 'Game Price'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a price.';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _editedGame = _editedGame.copyWith(price: double.parse(value!));
      },
    );
  }

  TextFormField _buildDescriptionField() {
    return TextFormField(
      initialValue: _editedGame.description,
      decoration: const InputDecoration(labelText: 'Description'),
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description.';
        }
        if (value.length < 10) {
          return 'Should be at least 10 characters long.';
        }
        return null;
      },
      onSaved: (value) {
        _editedGame = _editedGame.copyWith(description: value);
      },
    );
  }

  Widget _buildGameImagePreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(top: 8, right: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: !_editedGame.hasFeaturedImage()
              ? const Center(
                  child: Text('No Image'),
                )
              : FittedBox(
                  child: _editedGame.featuredImage == null
                      ? Image.network(
                          _editedGame.imageUrl,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          _editedGame.featuredImage!,
                          fit: BoxFit.cover,
                        ),
                ),
        ),
        Expanded(
          child: SizedBox(height: 100, child: _buildImagePickerButton()),
        ),
      ],
    );
  }

  TextButton _buildImagePickerButton() {
    return TextButton.icon(
      icon: const Icon(Icons.image),
      label: const Text('Pick Image'),
      onPressed: () async {
        final imagePicker = ImagePicker();
        try {
          final imageFile = await imagePicker.pickImage(
            source: ImageSource.gallery,
          );

          if (imageFile == null) {
            return;
          }

          _editedGame = _editedGame.copyWith(
            featuredImage: File(imageFile.path),
          );

          setState(() {});
        } catch (error) {
          if (mounted) {
            await showErrorDialog(context, 'Something went wrong.');
          }
        }
      },
    );
  }

  Future<void> _saveForm() async {
    final isValid =
        _editForm.currentState!.validate() && _editedGame.hasFeaturedImage();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    try {
      final productsManager = context.read<GamesManager>();
      if (_editedGame.id != null) {
        await productsManager.updateGame(_editedGame);
      } else {
        await productsManager.addGame(_editedGame);
      }
    } catch (error) {
      if (mounted) {
        await showErrorDialog(context, 'Something went wrong.');
      }
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add + Edit Game',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _editForm,
          child: ListView(
            children: <Widget>[
              _buildNameField(),
              const SizedBox(height: 10),
              _buildReleaseDateField(),
              const SizedBox(height: 10),
              _buildDeveloperField(),
              const SizedBox(height: 10),
              _buildPublisherField(),
              const SizedBox(height: 10),
              _buildCategoryField(),
              const SizedBox(height: 10),
              _buildPriceField(),
              const SizedBox(height: 10),
              _buildGameImagePreview(),
              const SizedBox(height: 10),
              _buildDescriptionField(),
            ],
          ),
        ),
      ),
    );
  }
}
