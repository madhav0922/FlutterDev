import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _form = GlobalKey<FormState>();
  // global key used to save form, rarely used.
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;

  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocusNode.addListener(_updateImageUrl);
    // _updateImageUrl() not initialized because we dont want tocall it when initState gets parsed or read,
    // but only want to give a pointer reference so that it only executes through addListener.
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null)
      // since if it is not null,  it automatically implies that an existing product is being accesed.
      {
        _editedProduct = Provider.of<Products>(context).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          //'imageUrl': _editedProduct.imageUrl, // Dont set it here, set using controller, set imageUrl as empty here.
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // DISPOSING elements such as following is important to avoid memory leaks.
  @override
  void dispose() {
    // TODO: implement dispose
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    //Super safe to dispose it before disposing imageUrlFocusNode.
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) return;
    }
    setState(() {
// It's a bit of a hack because we don't update the state ourselves
// but we know that the state has updated, that we have an updated value in
// imageUrlController and we want to rebuild the screen to reflect that updated value in
// imageUrlController since that value in imageUrlController is the image you want to preview.
    });
  }

  void _saveform() {
    final _isValid = _form.currentState.validate();
    // will validate all existing validators in the form.
    if (!_isValid) return;
    // return if validation fails else execute further lines.
    _form.currentState.save(); // method provided by flutter to save a form.
    // print(_editedProduct.title);
    if (_editedProduct.id != null)
    // great criteria to check as an existing product will only have an id.
    {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      // else add product
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }
    // print(_editedProduct.price);
    // print(_editedProduct.description);
    // print(_editedProduct.imageUrl);
    //use of provider. and context is available everywhere in your state object.
    Navigator.of(context).pop(); // Pop the current page after saving.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _saveform),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // Form is a stateful widget.
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                // To point to the next field when next button is pressed on keyboard.
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please enter a title'; // returning a string is considered as error.
                  return null; // however, returning null in validator is considered as no error.
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: value,
                    price: _editedProduct.price,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    isFavorite: _editedProduct.isFavorite,
                  );
                  //earlier id and favorite status was not added, however, now it is required as we are updating an existing product, we dont want to lose its favorite status.
                },
                // To manually control the focus to next field.
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                validator: (value) {
                  if (value.isEmpty) return 'Please specify a price.';
                  if (double.tryParse(value) == null)
                    return 'Please enter a valid number';
                  // used tryParse because unlike parse it does not throw an error if it fails, but returns null if it does fail.
                  if (double.parse(value) <= 0)
                    // Now we used .parse, since we know now the parsing will succeed since, it skipped the above if statement.
                    return 'Please enter a price greater than 0.';
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    price: double.parse(value),
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    isFavorite: _editedProduct.isFavorite,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                // Bigger than normal textFiled, as it shows 3 lines here.
                keyboardType: TextInputType.multiline,
                // keyboard has a next line enter button at bottom right.
                // Drawback: user has to manually tap out of it into next field as we don't know when user is finished, hence onFieldSubmitted was removed.
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value.isEmpty) return 'Please enter a description.';
                  if (value.length < 10)
                    return 'Description should be atleast 10 characters long.';
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    price: _editedProduct.price,
                    description: value,
                    imageUrl: _editedProduct.imageUrl,
                    isFavorite: _editedProduct.isFavorite,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 20, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Center(
                            child: Text('Enter a URL'),
                          )
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              // fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    // as textformfield has infinite width as so does Row, hence will cause error without Expanded
                    child: TextFormField(
                      // initialValue: _initValues['title'],
                      // initialValue: here can't be used together with a controller. therefore, fix controller to set initial value.
                      decoration: InputDecoration(labelText: 'Image URL'),
                      textInputAction: TextInputAction.done,
                      // will help refresh the Image to get loaded.
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) => _saveform(),
                      // anonymous function used, since onFieldSubmitted expects a String which we dont have for _saveform().
                      validator: (value) {
                        // Regular expressions can be used.
                        if (value.isEmpty) return 'Please add an image URL.';
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid image URL.';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg'))
                          return 'Please enter a valid image URL.';
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          imageUrl: value,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
