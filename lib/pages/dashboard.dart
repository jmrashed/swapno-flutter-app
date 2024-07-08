import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'profile_screen.dart'; // Import Profile Screen
import 'products_screen.dart'; // Import Products Screen
import 'orders_screen.dart'; // Import Orders Screen

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    HomeScreen(),
    ProductsScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-commerce Dashboard'),
      ),
      drawer: _buildDrawer(context),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Dashboard Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              _onItemTapped(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text('Products'),
            onTap: () {
              _onItemTapped(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Orders'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              _onItemTapped(3);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDashboardCard(
                title: 'Total Sales',
                value: '\$123,456',
                icon: Icons.monetization_on,
                color: Colors.green,
              ),
              _buildDashboardCard(
                title: 'Products',
                value: '1,234',
                icon: Icons.store,
                color: Colors.blue,
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDashboardCard(
                title: 'Orders',
                value: '567',
                icon: Icons.shopping_cart,
                color: Colors.orange,
              ),
              _buildDashboardCard(
                title: 'Customers',
                value: '890',
                icon: Icons.people,
                color: Colors.red,
              ),
            ],
          ),
          SizedBox(height: 16),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildRecentOrders(),
              _buildRecentProducts(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
      {required String title,
      required String value,
      required IconData icon,
      required Color color}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 150,
        height: 170,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrders() {
    // Dummy data for recent orders
    final recentOrders = [
      {'orderId': '1001', 'customer': 'John Doe', 'amount': '\$120.50'},
      {'orderId': '1002', 'customer': 'Jane Smith', 'amount': '\$85.75'},
      {'orderId': '1003', 'customer': 'Sam Wilson', 'amount': '\$45.00'},
    ];

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Orders',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ...recentOrders.map((order) {
              return ListTile(

              onTap: ()  {
                Fluttertoast.showToast(
                  msg: "Order ID: ${order['orderId']}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0
                );
              },
                title: Text('Order #${order['orderId']}'),
                subtitle: Text('Customer: ${order['customer']}'),
                trailing: Text(order['amount']!),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentProducts() {
    // Dummy data for recent products
    final recentProducts = [
      {'productId': 'P101', 'name': 'Product 1', 'price': '\$30.00'},
      {'productId': 'P102', 'name': 'Product 2', 'price': '\$25.00'},
      {'productId': 'P103', 'name': 'Product 3', 'price': '\$20.00'},
    ];

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Products',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...recentProducts.map((product) {

              return ListTile(
              onTap: ()  {
                Fluttertoast.showToast(
                  msg: "Product ID: ${product['productId']}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0
                );
              }
              ,
                title: Text('Product ID: ${product['productId']}'),
                subtitle: Text('Name: ${product['name']}'),
                trailing: Text(product['price']!),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
