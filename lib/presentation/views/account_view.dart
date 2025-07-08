import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade900,

        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?img=12',
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Ankush Gaur",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "ankush@example.com",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Quick Access Cards
          _buildQuickActionTile(
            icon: Icons.shopping_bag,
            label: "My Orders",
            onTap: () => Navigator.pushNamed(context, "/orders"),
          ),
          _buildQuickActionTile(
            icon: Icons.favorite,
            label: "Wishlist",
            onTap: () {},
          ),
          _buildQuickActionTile(
            icon: Icons.location_on,
            label: "Saved Addresses",
            onTap: () {},
          ),
          _buildQuickActionTile(
            icon: Icons.payment,
            label: "Payment Methods",
            onTap: () {},
          ),
          _buildQuickActionTile(
            icon: Icons.local_offer,
            label: "My Coupons",
            onTap: () {},
          ),
          _buildQuickActionTile(
            icon: Icons.headset_mic,
            label: "Help & Support",
            onTap: () {},
          ),
          _buildQuickActionTile(
            icon: Icons.settings,
            label: "Settings",
            onTap: () {},
          ),
          const Divider(height: 32),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Log Out", style: TextStyle(color: Colors.red)),
            onTap: () {
              // handle logout
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
