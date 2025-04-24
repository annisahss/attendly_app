import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendly_app/presentation/providers/auth_provider.dart';
import 'package:attendly_app/presentation/providers/theme_provider.dart';
import 'package:attendly_app/presentation/pages/auth/login_page.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 40),
            ),
            const SizedBox(height: 16),
            auth.name == null
                ? const CircularProgressIndicator()
                : Column(
                  children: [
                    Text(
                      auth.name!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      auth.email ?? '-',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
            const SizedBox(height: 32),

            // 🌗 Theme Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark Mode'),
                Switch(
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ✏️ Edit Profile Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfilePage()),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
            ),

            const SizedBox(height: 16),

            // 🚪 Logout Button
            ElevatedButton.icon(
              onPressed: () async {
                await auth.logout();

                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
