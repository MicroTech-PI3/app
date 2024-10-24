
import 'package:app/carro_compra/carrito_servicio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarritoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CarritoService carritoService = Get.find<CarritoService>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras', style: TextStyle(color: Color(0xFFFAFAFA))),
        centerTitle: true,
        backgroundColor: Color(0xFF09184D),
      ),
      body: Obx(() => ListView.builder(
            itemCount: carritoService.productos.length,
            itemBuilder: (context, index) {
              final producto = carritoService.productos[index];
              return ListTile(
                title: Text(producto['NAME']),
                subtitle: Text('\$ ${producto['PRICE']} pesos'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(producto['IMAGE']),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => carritoService.eliminarProducto(index),
                ),
              );
            },
          )),
      bottomNavigationBar: Obx(() => Padding(
            padding: const EdgeInsets.all(12),
            child: Row( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart, size: 24, color: Color(0xFF09184D)), 
                SizedBox(width: 8), 
                Text(
                  'Total de artículos: ${carritoService.productos.length}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    );
  }
}
