import 'package:app/categories/categories_list.dart';
import 'package:app/kpis/kpis_list.dart';
import 'package:app/customers/customers_all.dart';
import 'package:app/productos/add_products.dart';
import 'package:app/productos/all_products.dart';
import 'package:app/suppliers/suppliers_all.dart';
import 'package:flutter/material.dart';

class MenuOpcionesHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal',
            style: TextStyle(color: Color(0xFFFAFAFA))),
        backgroundColor: const Color(0xFF09184D),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerProductosPage(),
                  ),
                );
              },
              child: SizedBox(
                width: 300,
                height: 80,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.menu, size: 25, color: Color(0xFF09184D)),
                        SizedBox(width: 16),
                        Text(
                          'Ver Productos',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            //PROVEEDORES
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaSuppliers(),
                  ),
                );
              },
              child: SizedBox(
                width: 300,
                height: 80,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person, size: 25, color: Color(0xFF09184D)),
                        SizedBox(width: 16),
                        Text(
                          'Proveedores',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            //CATEGORIES
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoriesList(),
                  ),
                );
              },
              child: SizedBox(
                width: 300,
                height: 80,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.category,
                            size: 25, color: Color(0xFF09184D)),
                        SizedBox(width: 16),
                        Text(
                          'Categorías',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            //KPIS
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KpisList(),
                  ),
                );
              },
              child: SizedBox(
                width: 300,
                height: 80,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.bar_chart,
                            size: 25, color: Color(0xFF09184D)),
                        SizedBox(width: 16),
                        Text(
                          'Estadísticas y KPIs',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            //CLIENTES
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaCustomers(),
                  ),
                );
              },
              child: SizedBox(
                width: 300,
                height: 80,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person, size: 25, color: Color(0xFF09184D)),
                        SizedBox(width: 16),
                        Text(
                          'Clientes',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
