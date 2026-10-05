
import 'package:flutter/material.dart';
import 'package:wrenchgo/login.dart';
import 'package:wrenchgo/mech_booking_history.dart';
import 'package:wrenchgo/mech_dash.dart';
import 'package:wrenchgo/mech_earnings.dart';
import 'package:wrenchgo/service_request.dart';

class MechanicProfile extends StatefulWidget {
  const MechanicProfile({super.key});

  @override
  State<MechanicProfile> createState() => _MechanicProfileState();
}

class _MechanicProfileState extends State<MechanicProfile> {
  bool isActive = true;
  int selectedIndex = 4;

  final Color backgroundColor = const Color(0xFFEEF4FF);
  final Color primaryBlue = const Color(0xFF2563EB);
  final Color orange = const Color(0xFFFF6B00);

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _selectMenu(String item) {
    _showMessage('$item selected');
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showMessage('Logged out');
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _onBottomNavigationTap(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MechanicDashboard()));
        }
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MechanicBookingHistory()));
        }
        if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceRequest()));
        }
        if (index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MechanicEarnings()));
        }
        if (index == 4) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MechanicProfile()));
        }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
          child: Column(
            children: [
              _profileHeader(),
              const SizedBox(height: 25),
              _availabilityButtons(),
              const SizedBox(height: 25),
              _menuSection(),
              const SizedBox(height: 25),
              _logoutButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _profileHeader() {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: primaryBlue.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person,
            size: 55,
            color: primaryBlue,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Indra',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Indra123@gmail.com',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          '+91 45678 25836',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _availabilityButtons() {
    return Row(
      children: [
        Expanded(
          child: _availabilityButton(
            title: 'Active',
            icon: Icons.check_circle,
            color: primaryBlue,
            selected: isActive,
            onTap: () {
              setState(() {
                isActive = true;
              });
              _showMessage('Profile is Active');
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _availabilityButton(
            title: 'Inactive',
            icon: Icons.cancel,
            color: orange,
            selected: !isActive,
            onTap: () {
              setState(() {
                isActive = false;
              });
              _showMessage('Profile is Inactive');
            },
          ),
        ),
      ],
    );
  }

  Widget _availabilityButton({
    required String title,
    required IconData icon,
    required Color color,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? color : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: selected ? Colors.white : color,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuSection() {
    final menuItems = [
      {
        'title': 'Notification settings',
        'icon': Icons.notifications_outlined,
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

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          for (int i = 0; i < menuItems.length; i++)
            Column(
              children: [
                ListTile(
                  leading: Icon(
                    menuItems[i]['icon'] as IconData,
                    color: primaryBlue,
                  ),
                  title: Text(
                    menuItems[i]['title'] as String,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _selectMenu(menuItems[i]['title'] as String);
                  },
                ),
                if (i != menuItems.length - 1)
                  const Divider(
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _logoutButton() {
    return TextButton.icon(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
      },
      icon: Icon(
        Icons.logout,
        color: orange,
      ),
      label: Text(
        'Logout',
        style: TextStyle(
          color: orange,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _bottomNavigationBar() {
    final items = [
      {
        'icon': Icons.home_outlined,
        'label': 'Home',
      },
      {
        'icon': Icons.calendar_month_outlined,
        'label': 'Bookings',
      },
      {
        'icon': Icons.add_circle_outline,
        'label': 'New Booking',
      },
      {
        'icon': Icons.account_balance_wallet_outlined,
        'label': 'Earnings',
      },
      {
        'icon': Icons.person_outline,
        'label': 'Profile',
      },
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE0E0E0),
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            items.length,
            (index) {
              final isSelected = selectedIndex == index;

              return Expanded(
                child: InkWell(
                  onTap: () => _onBottomNavigationTap(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          items[index]['icon'] as IconData,
                          size: 25,
                          color: isSelected
                              ? const Color(0xFF0088FF)
                              : Colors.black,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          items[index]['label'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: isSelected
                                ? const Color(0xFF0088FF)
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
