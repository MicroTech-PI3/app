import 'package:app/escaneo_producto/home_page.dart';
import 'package:app/escaneo_producto/home_page.dart';
import 'package:app/escaneo_producto/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escanear Producto',
            style: TextStyle(color: Color(0xFFFAFAFA))),
        backgroundColor: Color(0xFF09184D),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => controller.escanearCodigoBarras(context),
              icon: Icon(Icons.qr_code, color: Colors.white), 
              label: Text(
                'Escanear Código',
                style: TextStyle(color: Colors.white,fontSize: 18), 
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF09184D), 
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), 
                ),
                elevation: 10, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
