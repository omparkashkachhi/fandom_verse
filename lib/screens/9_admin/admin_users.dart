import 'package:flutter/material.dart';

class AdminUsers extends StatefulWidget {
  const AdminUsers({super.key});

  @override
  State<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> users = [
    {
      'name': 'Ali Khan',
      'email': 'ali@gmail.com',
      'role': 'Fan',
      'status': 'Active',
      'joined': '12 Sep 2026',
    },
    {
      'name': 'Sara Ahmed',
      'email': 'sara@gmail.com',
      'role': 'Fan',
      'status': 'Active',
      'joined': '10 Sep 2026',
    },
    {
      'name': 'Hassan Raza',
      'email': 'hassan@gmail.com',
      'role': 'Moderator',
      'status': 'Active',
      'joined': '08 Sep 2026',
    },
    {
      'name': 'Ayesha Noor',
      'email': 'ayesha@gmail.com',
      'role': 'Fan',
      'status': 'Blocked',
      'joined': '05 Sep 2026',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05021A),
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/fandom_background.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF05021A),
                );
              },
            ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.55),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                _topBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _header(),
                        const SizedBox(height: 25),
                        _stats(),
                        const SizedBox(height: 25),
                        _searchAndAdd(),
                        const SizedBox(height: 25),
                        _usersList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TOP BAR
  Widget _topBar() {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: const Color(0xFF090624).withOpacity(0.95),
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFF2E2860),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 10),

          Image.asset(
            'assets/images/fandom_logo_clean.png',
            width: 100,
            height: 55,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Text(
                'FANDOM',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),

          const Spacer(),

          const Icon(
            Icons.notifications_none_rounded,
            color: Colors.white,
            size: 25,
          ),

          const SizedBox(width: 20),

          const CircleAvatar(
            radius: 19,
            backgroundColor: Color(0xFFC05CFF),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 21,
            ),
          ),
        ],
      ),
    );
  }

  // HEADER
  Widget _header() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User Management',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 7),
        Text(
          'Manage Fandom users and their accounts',
          style: TextStyle(
            color: Color(0xFFAEB3DD),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // STAT CARDS
  Widget _stats() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < 700) {
          return Column(
            children: [
              _statCard(
                'Total Users',
                '1,248',
                Icons.people_alt_outlined,
                const Color(0xFFB72CFF),
              ),
              const SizedBox(height: 12),
              _statCard(
                'Active Users',
                '1,102',
                Icons.person_outline,
                const Color(0xFF2277FF),
              ),
              const SizedBox(height: 12),
              _statCard(
                'Blocked',
                '36',
                Icons.block_outlined,
                const Color(0xFFFF4F81),
              ),
              const SizedBox(height: 12),
              _statCard(
                'New Users',
                '84',
                Icons.person_add_alt_1_outlined,
                const Color(0xFF35D6C8),
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _statCard(
                'Total Users',
                '1,248',
                Icons.people_alt_outlined,
                const Color(0xFFB72CFF),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _statCard(
                'Active Users',
                '1,102',
                Icons.person_outline,
                const Color(0xFF2277FF),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _statCard(
                'Blocked',
                '36',
                Icons.block_outlined,
                const Color(0xFFFF4F81),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _statCard(
                'New Users',
                '84',
                Icons.person_add_alt_1_outlined,
                const Color(0xFF35D6C8),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _statCard(
      String title,
      String value,
      IconData icon,
      Color iconColor,
      ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0929).withOpacity(0.90),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF302866),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.13),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFAEB3DD),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // SEARCH + ADD
  Widget _searchAndAdd() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 600;

        if (isSmall) {
          return Column(
            children: [
              _searchBox(),
              const SizedBox(height: 12),
              _addUserButton(),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: _searchBox()),
            const SizedBox(width: 15),
            _addUserButton(),
          ],
        );
      },
    );
  }

  Widget _searchBox() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFF0C0929).withOpacity(0.90),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF302866),
        ),
      ),
      child: TextField(
        controller: searchController,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search users by name or email...',
          hintStyle: TextStyle(
            color: Color(0xFF777DAA),
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Color(0xFFB5B9F0),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget _addUserButton() {
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add User feature is UI only for now.'),
            ),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add User'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB72CFF),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  // USERS LIST
  Widget _usersList() {
    return Column(
      children: users.map((user) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _userCard(user),
        );
      }).toList(),
    );
  }

  Widget _userCard(Map<String, dynamic> user) {
    final bool active = user['status'] == 'Active';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0929).withOpacity(0.92),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF302866),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _userInfo(user),
                const SizedBox(height: 15),
                Row(
                  children: [
                    _statusBadge(
                      user['status'],
                      active,
                    ),
                    const Spacer(),
                    _actionButtons(user),
                  ],
                ),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                child: _userInfo(user),
              ),
              _statusBadge(
                user['status'],
                active,
              ),
              const SizedBox(width: 25),
              _actionButtons(user),
            ],
          );
        },
      ),
    );
  }

  Widget _userInfo(Map<String, dynamic> user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: const Color(0xFFB72CFF).withOpacity(0.18),
          child: Text(
            user['name']
                .toString()
                .substring(0, 1)
                .toUpperCase(),
            style: const TextStyle(
              color: Color(0xFFC05CFF),
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user['email'],
                style: const TextStyle(
                  color: Color(0xFF9298C5),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${user['role']} • Joined ${user['joined']}',
                style: const TextStyle(
                  color: Color(0xFF73799F),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusBadge(String status, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFF35D6C8).withOpacity(0.12)
            : const Color(0xFFFF4F81).withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: active
              ? const Color(0xFF35D6C8)
              : const Color(0xFFFF4F81),
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _actionButtons(Map<String, dynamic> user) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Edit ${user['name']} - UI only',
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.edit_outlined,
            color: Color(0xFFB5B9F0),
            size: 20,
          ),
          tooltip: 'Edit',
        ),
        IconButton(
          onPressed: () {
            _showDeleteDialog(user['name']);
          },
          icon: const Icon(
            Icons.delete_outline_rounded,
            color: Color(0xFFFF4F81),
            size: 20,
          ),
          tooltip: 'Delete',
        ),
      ],
    );
  }

  void _showDeleteDialog(String name) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF100C32),
          title: const Text(
            'Delete User',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete $name?',
            style: const TextStyle(
              color: Color(0xFFAEB3DD),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFFAEB3DD),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Delete feature is UI only for now.',
                    ),
                  ),
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Color(0xFFFF4F81),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}