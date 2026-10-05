
import 'package:flutter/material.dart';
import 'package:wrenchgo/admin_dash.dart';
import 'package:wrenchgo/manage_mechanics.dart';
import 'package:wrenchgo/manage_users.dart';
import 'package:wrenchgo/manage_verification.dart';
import 'package:wrenchgo/reports_analytics.dart';

class ManageBooking extends StatefulWidget {
  const ManageBooking({super.key});

  @override
  State<ManageBooking> createState() => _ManageBookingState();
}

class _ManageBookingState extends State<ManageBooking> {
  int selectedFilter = 0;
  int selectedPage = 1;

  final TextEditingController searchController = TextEditingController();

  final List<String> filters = [
    'All (128)',
    'Pending (28)',
    'Conformed (45)',
    'In progress (23)',
  ];

  final List<Map<String, dynamic>> bookings = [
    {
      'id': '#WG123654',
      'mechanic': 'Ravi Mechanic',
      'service': 'Engine Repair',
      'date': '08 Aug 26, 10:30 AM',
      'location': 'MG road, Vijayawada, AP',
      'amount': '350.00',
      'status': 'Confirmed',
      'icon': Icons.car_repair,
    },
    {
      'id': '#WG741852',
      'mechanic': 'Speed Fixers',
      'service': 'Battery Jumpstart',
      'date': '08 Aug 26, 11:30 AM',
      'location': 'Race course road, Rajkot, GJ',
      'amount': '250.00',
      'status': 'In Progress',
      'icon': Icons.battery_charging_full,
    },
    {
      'id': '#WG951756',
      'mechanic': 'Quick Service',
      'service': 'Oil Change',
      'date': '08 Aug 26, 12:00 PM',
      'location': 'Trumba Highway, Rajkot, Gujarat',
      'amount': '199.00',
      'status': 'Completed',
      'icon': Icons.oil_barrel_outlined,
    },
    {
      'id': '#WG789963',
      'mechanic': 'Kumar Motors',
      'service': 'Tyre Service',
      'date': '08 Aug 26, 02:30 PM',
      'location': 'Ajidam, Rajkot, Gujarat',
      'amount': '180.00',
      'status': 'Pending',
      'icon': Icons.tire_repair,
    },
  ];

  List<Map<String, dynamic>> get filteredBookings {
    if (selectedFilter == 0) {
      return bookings;
    }

    final filter = filters[selectedFilter];

    if (filter.startsWith('Pending')) {
      return bookings.where((booking) {
        return booking['status'] == 'Pending';
      }).toList();
    }

    if (filter.startsWith('Conformed')) {
      return bookings.where((booking) {
        return booking['status'] == 'Confirmed';
      }).toList();
    }

    if (filter.startsWith('In progress')) {
      return bookings.where((booking) {
        return booking['status'] == 'In Progress';
      }).toList();
    }

    return bookings;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showBookingDetails(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(booking['id']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dialogRow('Mechanic', booking['mechanic']),
              _dialogRow('Service', booking['service']),
              _dialogRow('Date', booking['date']),
              _dialogRow('Location', booking['location']),
              _dialogRow('Amount', '₹${booking['amount']}'),
              _dialogRow('Status', booking['status']),
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

  Widget _dialogRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 75,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _rescheduleBooking(Map<String, dynamic> booking) {
    _showMessage(
      'Reschedule requested for ${booking['id']}',
    );
  }

  void _cancelBooking(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cancel Booking'),
          content: Text(
            'Are you sure you want to cancel ${booking['id']}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                setState(() {
                  booking['status'] = 'Cancelled';
                });

                _showMessage('Booking cancelled');
              },
              child: const Text('Yes, Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _trackBooking(Map<String, dynamic> booking) {
    _showMessage(
      'Tracking ${booking['mechanic']}',
    );
  }

  void _confirmBooking(Map<String, dynamic> booking) {
    setState(() {
      booking['status'] = 'Confirmed';
    });

    _showMessage('Booking confirmed');
  }

  void _viewInvoice(Map<String, dynamic> booking) {
    _showMessage(
      'Opening invoice for ${booking['id']}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FF),
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
                child: Column(
                  children: [
                    _searchBar(),
                    const SizedBox(height: 12),
                    _filterTabs(),
                    const SizedBox(height: 12),
                    _bookingList(),
                    const SizedBox(height: 14),
                    _pagination(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
          const Expanded(
            child: Text(
              'Manage Booking',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: 'Search by Booking ID, Service.......',
          hintStyle: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 13,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF64748B),
          ),
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.clear),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
        ),
      ),
    );
  }

  Widget _filterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          filters.length,
          (index) {
            final selected = selectedFilter == index;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedFilter = index;
                    selectedPage = 1;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF2563EB)
                        : Colors.white,
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF2563EB)
                          : Colors.black26,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    filters[index],
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _bookingList() {
    final searchText = searchController.text.toLowerCase();

    final displayedBookings = filteredBookings.where((booking) {
      if (searchText.isEmpty) {
        return true;
      }

      return booking['id']
              .toString()
              .toLowerCase()
              .contains(searchText) ||
          booking['service']
              .toString()
              .toLowerCase()
              .contains(searchText) ||
          booking['mechanic']
              .toString()
              .toLowerCase()
              .contains(searchText);
    }).toList();

    if (displayedBookings.isEmpty) {
      return _emptyState();
    }

    return Column(
      children: displayedBookings.map((booking) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _bookingCard(booking),
        );
      }).toList(),
    );
  }

  Widget _bookingCard(Map<String, dynamic> booking) {
    final status = booking['status'] as String;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bookingIcon(booking['icon']),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          booking['id'],
                          style: const TextStyle(
                            color: Color(0xFF386BF6),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        _statusBadge(status),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text(
                      booking['mechanic'],
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      booking['service'],
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 13,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            booking['date'],
                            style: const TextStyle(
                              fontSize: 9,
                            ),
                          ),
                        ),
                        Text(
                          '₹${booking['amount']}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 13,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            booking['location'],
                            style: const TextStyle(
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _actionButtons(booking),
        ],
      ),
    );
  }

  Widget _bookingIcon(IconData icon) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: const Color(0xFFEEF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        size: 30,
        color: const Color(0xFF2563EB),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color background;
    Color foreground;

    switch (status) {
      case 'Confirmed':
        background = const Color(0xFFE4F5C9);
        foreground = const Color(0xFF3C8332);
        break;

      case 'In Progress':
        background = const Color(0xFFC5D4F2);
        foreground = const Color(0xFF0044FF);
        break;

      case 'Completed':
        background = const Color(0xFFD5EDC4);
        foreground = const Color(0xFF309318);
        break;

      case 'Pending':
        background = const Color(0xFFEECF91);
        foreground = Colors.red;
        break;

      case 'Cancelled':
        background = const Color(0xFFFFD4D4);
        foreground = Colors.red;
        break;

      default:
        background = Colors.grey.shade200;
        foreground = Colors.black;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: foreground,
          fontSize: 9,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _actionButtons(Map<String, dynamic> booking) {
    final status = booking['status'] as String;

    final buttons = <Widget>[
      _actionButton(
        label: 'View Details',
        onPressed: () => _showBookingDetails(booking),
      ),
    ];

    if (status == 'Confirmed') {
      buttons.add(
        _actionButton(
          label: 'Reschedule',
          onPressed: () => _rescheduleBooking(booking),
        ),
      );

      buttons.add(
        _actionButton(
          label: 'Track',
          filled: true,
          onPressed: () => _trackBooking(booking),
        ),
      );
    } else if (status == 'In Progress') {
      buttons.add(
        _actionButton(
          label: 'Cancel Booking',
          filled: true,
          danger: true,
          onPressed: () => _cancelBooking(booking),
        ),
      );
    } else if (status == 'Completed') {
      buttons.add(
        _actionButton(
          label: 'View Invoice',
          filled: true,
          onPressed: () => _viewInvoice(booking),
        ),
      );
    } else if (status == 'Pending') {
      buttons.add(
        _actionButton(
          label: 'Reschedule',
          onPressed: () => _rescheduleBooking(booking),
        ),
      );

      buttons.add(
        _actionButton(
          label: 'Confirm',
          filled: true,
          onPressed: () => _confirmBooking(booking),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: buttons,
    );
  }

  Widget _actionButton({
    required String label,
    required VoidCallback onPressed,
    bool filled = false,
    bool danger = false,
  }) {
    final color = danger
        ? Colors.red
        : const Color(0xFF220AF7);

    return SizedBox(
      height: 30,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor:
              filled ? color : const Color(0xFFF9F8FF),
          foregroundColor:
              filled ? Colors.white : const Color(0xFF0044FF),
          side: BorderSide(
            color: color,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 9,
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 45,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.event_busy_outlined,
            size: 45,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            'No bookings found',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Try another filter or search term.',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pagination() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      color: const Color(0xFFF2EEEE),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Showing 1 to 128 booking',
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          ),
          IconButton(
            onPressed: selectedPage > 1
                ? () {
                    setState(() {
                      selectedPage--;
                    });
                  }
                : null,
            icon: const Icon(
              Icons.chevron_left,
              size: 20,
            ),
          ),
          _pageButton(1),
          _pageButton(2),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '...',
              style: TextStyle(fontSize: 11),
            ),
          ),
          _pageButton(13),
          IconButton(
            onPressed: selectedPage < 13
                ? () {
                    setState(() {
                      selectedPage++;
                    });
                  }
                : null,
            icon: const Icon(
              Icons.chevron_right,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageButton(int page) {
    final selected = selectedPage == page;

    return InkWell(
      onTap: () {
        setState(() {
          selectedPage = page;
        });
      },
      child: Container(
        width: 28,
        height: 26,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF386BF6)
              : Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            fontSize: 10,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _bottomNavigationBar() {
    const items = [
      {
        'icon': Icons.dashboard_outlined,
        'label': 'Dashboard',
      },
      {
        'icon': Icons.calendar_month_outlined,
        'label': 'Bookings',
      },
      {
        'icon': Icons.engineering_outlined,
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

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE2E8F0),
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: List.generate(
            items.length,
            (index) {
              final selected = index == 1;

              return Expanded(
                child: InkWell(
                  onTap: () {
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          items[index]['icon'] as IconData,
                          size: 24,
                          color: selected
                              ? const Color(0xFF386BF6)
                              : Colors.black,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          items[index]['label'] as String,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: selected
                                ? const Color(0xFF386BF6)
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
