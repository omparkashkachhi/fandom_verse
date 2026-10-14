import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FandomDetailPage extends StatefulWidget {
  final String? fandomId;
  final String title;
  final String fans;
  final IconData icon;
  final String? imageUrl;
  final String? description;

  const FandomDetailPage({
    super.key,
    this.fandomId,
    required this.title,
    required this.fans,
    required this.icon,
    this.imageUrl,
    this.description,
  });

  @override
  State<FandomDetailPage> createState() => _FandomDetailPageState();
}

class _FandomDetailPageState extends State<FandomDetailPage> {
  bool _isJoined = false;
  final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _checkMembership();
  }

  void _checkMembership() async {
    if (widget.fandomId != null && currentUserId != null) {
      final doc = await FirebaseFirestore.instance
          .collection('fandoms')
          .doc(widget.fandomId)
          .collection('members')
          .doc(currentUserId)
          .get();

      if (mounted) {
        setState(() {
          _isJoined = doc.exists;
        });
      }
    }
  }

  void _toggleJoinFandom() async {
    if (widget.fandomId == null || currentUserId == null) return;

    final memberRef = FirebaseFirestore.instance
        .collection('fandoms')
        .doc(widget.fandomId)
        .collection('members')
        .doc(currentUserId);

    final fandomRef = FirebaseFirestore.instance
        .collection('fandoms')
        .doc(widget.fandomId);

    if (_isJoined) {
      await memberRef.delete();
      await fandomRef.update({
        'memberCount': FieldValue.increment(-1),
      });
      setState(() => _isJoined = false);
    } else {
      await memberRef.set({
        'joinedAt': FieldValue.serverTimestamp(),
      });
      await fandomRef.update({
        'memberCount': FieldValue.increment(1),
      });
      setState(() => _isJoined = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05021A),
      body: Stack(
        children: [
          // ==============================
          // BACKGROUND
          // ==============================
          Positioned.fill(
            child: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                ? Image.network(
              widget.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                'assets/images/fandom_background.png',
                fit: BoxFit.cover,
              ),
            )
                : Image.asset(
              'assets/images/fandom_background.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.55),
            ),
          ),

          // ==============================
          // CONTENT
          // ==============================
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==============================
                  // BACK & JOIN BUTTON ROW
                  // ==============================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: const Color(0xFF111637),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF7054D7),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      if (widget.fandomId != null)
                        ElevatedButton.icon(
                          onPressed: _toggleJoinFandom,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isJoined
                                ? Colors.white12
                                : const Color(0xFFFF4FD8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          icon: Icon(
                            _isJoined ? Icons.check : Icons.add_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          label: Text(
                            _isJoined ? 'Joined' : 'Join Fandom',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // ==============================
                  // BIG IMAGE OR ICON CONTAINER
                  // ==============================
                  Center(
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF4FD8),
                            Color(0xFF814DFF),
                            Color(0xFF19DFFF),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF814DFF).withOpacity(0.55),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: widget.imageUrl != null &&
                            widget.imageUrl!.isNotEmpty
                            ? (widget.imageUrl!.startsWith('assets/')
                            ? Image.asset(
                          widget.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            widget.icon,
                            color: Colors.white,
                            size: 52,
                          ),
                        )
                            : Image.network(
                          widget.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            widget.icon,
                            color: Colors.white,
                            size: 52,
                          ),
                        ))
                            : Icon(
                          widget.icon,
                          color: Colors.white,
                          size: 52,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ==============================
                  // TITLE
                  // ==============================
                  Center(
                    child: Text(
                      '${widget.title.toUpperCase()} FANDOM',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Center(
                    child: Text(
                      widget.fans,
                      style: const TextStyle(
                        color: Color(0xFFB47AFF),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // ==============================
                  // ABOUT CARD
                  // ==============================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C1333).withOpacity(0.94),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: const Color(0xFF504D91),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '✨ Explore this Fandom',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.description ??
                              'Discover trending content, connect with other fans, share your interests and explore everything related to ${widget.title}.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.62),
                            fontSize: 13,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ==============================
                  // OPTIONS
                  // ==============================
                  _optionCard(
                    icon: Icons.local_fire_department,
                    title: 'Trending Now',
                    subtitle: 'See what fans are talking about',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening trending posts for ${widget.title}...'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  _optionCard(
                    icon: Icons.groups_outlined,
                    title: 'Fan Community',
                    subtitle: 'Connect with other fans',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening ${widget.title} community...'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  _optionCard(
                    icon: Icons.star_outline_rounded,
                    title: 'Popular',
                    subtitle: 'Explore popular content',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening popular items for ${widget.title}...'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1435).withOpacity(0.94),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF4D4B91),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF4FD8),
                    Color(0xFF754DFF),
                    Color(0xFF19DFFF),
                  ],
                ),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFFB17AFF),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}