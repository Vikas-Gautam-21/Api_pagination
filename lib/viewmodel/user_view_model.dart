import 'package:api_call/models/user_model.dart';
import 'package:api_call/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService = UserService();
  final List<User> _users = [];
  List<User> get users => _users;

  int _page = 1;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserViewModel() {
    fetchUsers();
  }

  Future<void> fetchUsers({bool isLoadMore = false}) async {
    if (_isLoading || (!_hasMore && isLoadMore)) return;

    _isLoading = true;
    if (isLoadMore) {
      notifyListeners(); 
    } else {
      _page = 1;
      _users.clear();
      notifyListeners();
    }

    try {
      final response = await _userService.getUsers(_page);
      _users.addAll(response.data);
      _hasMore = response.page < response.totalPages;
      _page++;
      _isLoading = false;
      _errorMessage = null;
    } catch (error) {
      _errorMessage = error.toString();
      _isLoading = false;
    } finally {
      notifyListeners();
    }
  }
}