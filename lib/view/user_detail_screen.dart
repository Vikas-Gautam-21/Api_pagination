import 'package:api_call/models/user_model.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
              title: Text(' ${user.firstName} ${user.lastName}'),
              subtitle: Text(' ${user.email}'),
            ),
          ],
        ),
      ),
    );
  }
}
