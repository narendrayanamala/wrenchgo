
import 'package:flutter/material.dart';

class UserServices extends StatefulWidget {
  const UserServices({super.key});

  @override
  State<UserServices> createState() => _UserServicesState();
}

class _UserServicesState extends State<UserServices> {
  final List<Map<String, dynamic>> services = [
    {
      'name': 'Engine Repair',
      'description': 'Engine inspection and repair',
      'icon': Icons.car_repair,
    },
    {
      'name': 'Tyre Service',
      'description': 'Puncture and tyre repair',
      'icon': Icons.tire_repair,
    },
    {
      'name': 'Battery Service',
      'description': 'Battery check and replacement',
      'icon': Icons.battery_charging_full,
    },
    {
      'name': 'Oil Change',
      'description': 'Engine oil replacement',
      'icon': Icons.oil_barrel_outlined,
    },
    {
      'name': 'General Service',
      'description': 'Complete vehicle servicing',
      'icon': Icons.build_circle_outlined,
    },
    {
      'name': 'Towing Service',
      'description': 'Vehicle towing assistance',
      'icon': Icons.local_shipping_outlined,
    },
    {
      'name': 'Jumpstart',
      'description': 'Emergency battery jumpstart',
      'icon': Icons.bolt_outlined,
    },
    {
      'name': 'Roadside Assistance',
      'description': 'Emergency roadside support',
      'icon': Icons.support_agent,
    },
  ];

  void _selectService(String serviceName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$serviceName selected'),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Our Services',
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF386BF6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WrenchGo Services',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Get reliable roadside assistance and vehicle services anytime.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'What we provide',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 14),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: services.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final service = services[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _selectService(service['name']),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(11),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF0FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              service['icon'],
                              color: const Color(0xFF386BF6),
                              size: 28,
                            ),
                          ),

                          const Spacer(),

                          Text(
                            service['name'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            service['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
