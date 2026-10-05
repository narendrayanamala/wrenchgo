
import 'package:flutter/material.dart';
import 'package:wrenchgo/admin_dash.dart';
import 'package:wrenchgo/manage_booking.dart';
import 'package:wrenchgo/manage_mechanics.dart';
import 'package:wrenchgo/manage_verification.dart';
import 'package:wrenchgo/reports_analytics.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  int selectedIndex = 3;
  String searchText = '';
  String sortOption = 'Newest';

  final List<Map<String, dynamic>> users = [
    {
      'name': 'Harsha vardhan',
      'email': 'harsha@gmail.com',
      'phone': '91+ 9876543210',
      'joined': '08 Aug 2026',
      'status': 'Active',
    },
    {
      'name': 'Sowmya',
      'email': 'sowamya@gmail.com',
      'phone': '91+ 9341237092',
      'joined': '04 Aug 2026',
      'status': 'In Active',
    },
    {
      'name': 'Narendra Yanamala',
      'email': 'narendra@gmail.com',
      'phone': '91+ 8328470572',
      'joined': '26 Aug 2026',
      'status': 'Block',
    },
  ];

  List<Map<String, dynamic>> get filteredUsers {
    if (searchText.trim().isEmpty) {
      return users;
    }

    final query = searchText.toLowerCase();

    return users.where((user) {
      return user['name'].toString().toLowerCase().contains(query) ||
          user['email'].toString().toLowerCase().contains(query) ||
          user['phone'].toString().toLowerCase().contains(query);
    }).toList();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Active':
        return const Color(0xFF2D824C);
      case 'In Active':
        return const Color(0xFF986F15);
      case 'Block':
        return const Color(0xFF8B1414);
      default:
        return Colors.black;
    }
  }

  Color _statusBackground(String status) {
    switch (status) {
      case 'Active':
        return const Color(0xFFD6ECC7);
      case 'In Active':
        return const Color(0xFFEDCB87);
      case 'Block':
        return const Color(0xFFF1A2A2);
      default:
        return Colors.grey.shade200;
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showUserDetails(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(user['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dialogRow(Icons.email_outlined, user['email']),
              const SizedBox(height: 12),
              _dialogRow(Icons.phone_outlined, user['phone']),
              const SizedBox(height: 12),
              _dialogRow(
                Icons.calendar_today_outlined,
                'Joined on ${user['joined']}',
              ),
              const SizedBox(height: 12),
              _dialogRow(
                Icons.circle,
                user['status'],
                color: _statusColor(user['status']),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _dialogRow(
    IconData icon,
    String text, {
    Color? color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color ?? const Color(0xFF386BF6),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text)),
      ],
    );
  }

  void _changeUserStatus(
    Map<String, dynamic> user,
    String newStatus,
  ) {
    setState(() {
      user['status'] = newStatus;
    });

    _showMessage('${user['name']} is now $newStatus');
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final options = ['Newest', 'Oldest', 'Name A-Z', 'Name Z-A'];

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Sort Users',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...options.map(
                (option) {
                  return ListTile(
                    leading: Icon(
                      sortOption == option
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: const Color(0xFF386BF6),
                    ),
                    title: Text(option),
                    onTap: () {
                      setState(() {
                        sortOption = option;
                      });

                      Navigator.pop(context);
                      _showMessage('Sorted by $option');
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _userCard(Map<String, dynamic> user) {
    final status = user['status'];

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: const Color(0xFFEAF0FF),
              child: Icon(
                Icons.person,
                size: 38,
                color: const Color(0xFF386BF6),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          user['name'],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.more_vert,
                          size: 20,
                        ),
                        onSelected: (value) {
                          if (value == 'details') {
                            _showUserDetails(user);
                          } else if (value == 'active') {
                            _changeUserStatus(user, 'Active');
                          } else if (value == 'inactive') {
                            _changeUserStatus(user, 'In Active');
                          } else if (value == 'block') {
                            _changeUserStatus(user, 'Block');
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                            value: 'details',
                            child: Text('View Details'),
                          ),
                          PopupMenuItem(
                            value: 'active',
                            child: Text('Set Active'),
                          ),
                          PopupMenuItem(
                            value: 'inactive',
                            child: Text('Set In Active'),
                          ),
                          PopupMenuItem(
                            value: 'block',
                            child: Text('Block User'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _userInfo(
                    Icons.email_outlined,
                    user['email'],
                  ),
                  const SizedBox(height: 6),
                  _userInfo(
                    Icons.phone_outlined,
                    user['phone'],
                  ),
                  const SizedBox(height: 6),
                  _userInfo(
                    Icons.calendar_today_outlined,
                    'Joined on ${user['joined']}',
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: _statusBackground(status),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: _statusColor(status),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: const Color(0xFF64748B),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF475569),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color backgroundColor,
    required Color valueColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: valueColor,
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: valueColor,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBar() {
    final items = [
      {
        'icon': Icons.dashboard_outlined,
        'label': 'Dashboard',
      },
      {
        'icon': Icons.book_outlined,
        'label': 'Bookings',
      },
      {
        'icon': Icons.build_outlined,
        'label': 'Mechanics',
      },
      {
        'icon': Icons.people_outline,
        'label': 'Users',
      },
      {
        'icon': Icons.more_horiz,
        'label': 'More',
      },
    ];

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF386BF6),
      unselectedItemColor: Colors.black87,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });

        
    if (index==0){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
    }
    if (index==1){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageBooking()));
    }
    if (index==2){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageMechanics()));
    }
    if (index==3){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageUsers()));
    }
    if (index==4){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageVerification()));
    }
      },
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item['icon'] as IconData),
          label: item['label'] as String,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEF4FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Manage Users',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF386BF6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.people_alt_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manage Users',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '128 Registered Users',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.manage_accounts,
                      color: Colors.white54,
                      size: 45,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Statistics
              Row(
                children: [
                  _statCard(
                    title: 'All Users',
                    value: '128',
                    icon: Icons.people_outline,
                    backgroundColor: const Color(0xFFD8EBF8),
                    valueColor: const Color(0xFF2563EB),
                  ),
                  const SizedBox(width: 12),
                  _statCard(
                    title: 'Active Users',
                    value: '56',
                    icon: Icons.person_outline,
                    backgroundColor: const Color(0xFFE6F6E6),
                    valueColor: const Color(0xFF00A91A),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Search
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search user, email, phone...',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF64748B),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF386BF6),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Users title + sort
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Users',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: _showSortOptions,
                    icon: const Icon(
                      Icons.sort,
                      size: 17,
                    ),
                    label: Text(
                      'Sort: $sortOption',
                      style: const TextStyle(fontSize: 11),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        color: Color(0xFF949292),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // User list
              if (filteredUsers.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.person_search_outlined,
                        size: 45,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No users found',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...filteredUsers.map(_userCard),

              const SizedBox(height: 10),

              // Pagination
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2EEEE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Showing 1 to 5 of 128 Users',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    _pageButton('1', selected: true),
                    _pageButton('2'),
                    _pageButton('...'),
                    _pageButton('26'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _pageButton(
    String text, {
    bool selected = false,
  }) {
    return GestureDetector(
      onTap: () {
        _showMessage('Page $text selected');
      },
      child: Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.only(left: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF386BF6)
              : Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
