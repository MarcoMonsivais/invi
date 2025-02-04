import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invi/helpers/globals_variables.dart';
import 'package:invi/helpers/routes_constants.dart';
import 'package:invi/homepage/home_page.dart';
import 'package:invi/admin/product/showproduct_page.dart';
import 'package:invi/settings/settings_page.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  void goScreen(BuildContext context) {
    context.go('/${RoutesConstants.newproduct}');
  }

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {

  final _descriptionController = TextEditingController();
  final _keyController = TextEditingController();
  final _imageController = TextEditingController();
  final _priceController = TextEditingController();
  final _qntyController = TextEditingController();
  final _totalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Agregar Producto', 
          style: GoogleFonts.roboto(
            color: Colors.white, 
            fontWeight: FontWeight.bold
            ),
          ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            const SettingsPage().goScreen(context);
          },
        ),
        backgroundColor: Colors.brown.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            // Container(
            //   height: 100,
            //   width: 100,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     image: DecorationImage(
            //       image: NetworkImage(_imageController.text),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     final ImagePicker _picker = ImagePicker();
            //     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
            //     if (image != null) {
            //       setState(() {
            //         _imageController.text = image.path;
            //       });
            //     }
            //   },
            //   child: Text('Upload Image'),
            // ),

            TextField(
              controller: _keyController,
              decoration: InputDecoration(labelText: 'Key', labelStyle: GoogleFonts.roboto()),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description', labelStyle: GoogleFonts.roboto()),
            ),
            
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price', labelStyle: GoogleFonts.roboto()),
            ),
            TextField(
              controller: _qntyController,
              decoration: InputDecoration(labelText: 'Quantity', labelStyle: GoogleFonts.roboto()),
            ),
            /// add to calculate
            TextField(
              controller: _totalController,
              decoration: InputDecoration(labelText: 'Total', labelStyle: GoogleFonts.roboto()),
            ),
      
            ElevatedButton(
              onPressed: () {
                final author = {
                  'dateCreated': DateTime.now(),
                  'name': 'Marco Monsivais',
                  'id': FirebaseAuth.instance.currentUser!.uid,
                };
      
                final product = {
                  'author': author,
                  'description': _descriptionController.text,
                  'key': _keyController.text,
                  'image': _imageController.text,
                  'lastEdit': DateTime.now(),
                  'price': int.parse(_priceController.text),
                  'qnty': int.parse(_qntyController.text),
                  'total': int.parse(_totalController.text)
                };
      
                FirebaseFirestore.instance
                  .collection('app/conf/products')
                  .add(product).then((doc){
                    
                    _keyController.clear();
                    _descriptionController.clear();
                    _imageController.clear();
                    _priceController.clear();
                    _qntyController.clear();
                    _totalController.clear();

                    productId = doc.id;
                    productName = _keyController.text;

                    const ShowProduct_Page().goScreen(context);

                  })
                  .catchError((e) => print(e));
                  
              },
              
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade200,
                padding: const EdgeInsets.all(15),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                child: Text(
                  'Agregar Producto Nuevo',
                  style: GoogleFonts.roboto(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
