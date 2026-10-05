
import 'package:flutter/material.dart';
import 'package:wrenchgo/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'My Vehicles',
      'icon': Icons.directions_car_outlined,
    },
    {
      'title': 'My Wallet',
      'icon': Icons.account_balance_wallet_outlined,
      'amount': '₹1550.00',
    },
    {
      'title': 'Saved Addresses',
      'icon': Icons.location_on_outlined,
    },
    {
      'title': 'Notification Settings',
      'icon': Icons.notifications_none,
    },
    {
      'title': 'Help & Support',
      'icon': Icons.help_outline,
    },
    {
      'title': 'About Us',
      'icon': Icons.info_outline,
    },
    {
      'title': 'Edit Profile',
      'icon': Icons.edit_outlined,
    },
    {
      'title': 'Change Password',
      'icon': Icons.lock_outline,
    },
  ];

  void selectMenu(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title selected'),
      ),
    );
  }

  void logout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logout selected'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEF4FF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            children: [
              _profileHeader(),

              const SizedBox(height: 35),

              _menuList(),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Color(0xFFFF6B00),
                  ),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Color(0xFFFF6B00),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 105,
          height: 105,
          decoration: BoxDecoration(
            color: const Color(0xFFDCE7FF),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(
            Icons.person,
            size: 65,
            color: Color(0xFF2563EB),
          ),
        ),

        const SizedBox(width: 25),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Narendra',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'narendra123@gmail.com',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '+91 12345 67892',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _menuList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: menuItems.map((item) {
          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 4,
                ),
                leading: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF4FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item['icon'],
                    color: const Color(0xFF2563EB),
                  ),
                ),
                title: Text(
                  item['title'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: item['amount'] != null
                    ? Text(
                        item['amount'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFF64748B),
                      ),
                onTap: () {
                  selectMenu(item['title']);
                },
              ),
              if (item != menuItems.last)
                const Divider(
                  height: 1,
                  indent: 75,
                  endIndent: 15,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
