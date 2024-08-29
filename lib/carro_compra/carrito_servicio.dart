import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class CarritoService extends GetxController {
  final RxList<Map<String, dynamic>> _productos = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get productos => _productos;

 get total => _productos.fold(
      0.0, (sum, producto) => sum + (producto['PRICE'] ));

  // Método para agregar producto desde la API
  Future<void> agregarProductoAPI(
      BuildContext context, String codigoProducto) async {
    final pr = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: true);

    final url = 'http://microtech.icu:6969/product/${codigoProducto}';
    
    final response = await http.get(Uri.parse(url));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Si el servidor devuelve un 200 OK, parseamos el JSON
      data['IMAGE'] = 'microtech.icu/product/${data['IMAGE']}';
      Map<String, dynamic> nuevoProducto = data;

      // Agregar producto a la lista
      _productos.add(nuevoProducto);

      Get.snackbar('Producto Escaneado', data['NAME']);
    } else {
      // Si el servidor no devuelve un 200 OK, muestra un error
      Get.snackbar('Error', data['status']);
    }
    pr.hide();
  }




     Future<void> agregarCarrito(
      BuildContext context) async {


       final headers = {
    'Content-Type': 'application/json',
  };



  final body = jsonEncode(productos);
  

    const url = 'http://microtech.icu:6969/product/compra'; 
      final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: body,
  );
    if (response.statusCode == 200) {
      final id_carrito=response.body;
      print(id_carrito);
  }
      }




  // Métodos locales del carrito
  void agregarProductoLocal(Map<String, dynamic> producto) {
    _productos.add(producto);
  }

  void eliminarProducto(int index) {
    _productos.removeAt(index);
  }

  void limpiarCarrito() {
    _productos.clear();
  }
}
