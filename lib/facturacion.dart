import 'package:flutter/material.dart';
import 'escaneo_producto/home_page.dart';
import 'escaneo_producto/home_page_controller.dart';
import 'package:get/get.dart';

class Facturacionapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Facturación Electrónica',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFFAFAFA),
      ),
      home: FacturacionScreen(),
    );
  }
}

class FacturacionScreen extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MicroTech Solutions',
            style: TextStyle(color: Color(0xFFFAFAFA))),
        backgroundColor: const Color(0xFF7E57C2),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Datos tienda',
                style: TextStyle(color: Color(0xFF455A64))),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.productos.length,
                  itemBuilder: (context, index) {
                    final producto = controller.productos[index];
                    return Card(
                      color: const Color.fromARGB(255, 243, 238, 251),
                      child: ListTile(
                        title: Text(
                            '${producto['NAME']} (${producto['cantidad']})'),
                        trailing: Text('\$${producto['PRICE']}'),
                      ),
                    );
                  },
                )),
          ),
          Obx(() => const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /* Text('Total: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('\$${controller.total.toStringAsFixed(2)}'), */
                  ],
                ),
              )),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF09184D),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                backgroundColor: const Color(0xFF09184D),
                selectedItemColor: const Color(0xFFFAFAFA),
                unselectedItemColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                    if (index == 1) {
                      Get.to(() => HomePage());
                    } else if (index == 0) {
                      Get.to(() => FacturacionScreen());
                    }
                    // Agrega más condiciones según sea necesario
                  });
                },
                items: [
                  _buildNavItem(Icons.home, 'Inicio', 0),
                  _buildNavItem(Icons.qr_code, 'QR', 1),
                  _buildNavItem(Icons.attach_money, 'Pago', 2),
                  _buildNavItem(Icons.person, 'Perfil', 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedIndex == index ? Colors.white : Colors.transparent,
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          color:
              _selectedIndex == index ? const Color(0xFF09184D) : Colors.white,
        ),
      ),
      label: label,
    );
  }
}
