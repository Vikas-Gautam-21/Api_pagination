import 'package:api_call/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Provider.of<UserViewModel>(
        context,
        listen: false,
      ).fetchUsers(isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: Consumer<UserViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.users.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text('Error: ${viewModel.errorMessage}'));
          } else if (viewModel.users.isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            return ListView.builder(
              controller: _scrollController,
              itemCount:
                  viewModel.users.length +
                  (viewModel.hasMore && viewModel.users.isNotEmpty ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < viewModel.users.length) {
                  final user = viewModel.users[index];
                  return ListTile(
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                  );
                } else if (viewModel.hasMore && viewModel.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (!viewModel.hasMore && viewModel.users.isNotEmpty) {
                  return Center(child: Text('No more users.'));
                }
                return SizedBox.shrink(); 
              },
            );
          }
        },
      ),
    );
  }
}
