import 'package:flutter/material.dart';

class AdminPost extends StatefulWidget {
  const AdminPost({super.key});

  @override
  State<AdminPost> createState() => _AdminPostState();
}

class _AdminPostState extends State<AdminPost> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> posts = [
    {
      'title': 'Top 10 Movies Everyone Should Watch',
      'fandom': 'Movies',
      'author': 'Admin',
      'date': '25 Sep 2026',
      'status': 'Published',
      'icon': Icons.movie_outlined,
    },
    {
      'title': 'Best Anime Characters of All Time',
      'fandom': 'Anime',
      'author': 'Kanwal',
      'date': '24 Sep 2026',
      'status': 'Published',
      'icon': Icons.auto_awesome_outlined,
    },
    {
      'title': 'New Music Trends 2026',
      'fandom': 'Music',
      'author': 'Admin',
      'date': '23 Sep 2026',
      'status': 'Pending',
      'icon': Icons.music_note_outlined,
    },
    {
      'title': 'Gaming Community Updates',
      'fandom': 'Gaming',
      'author': 'Admin',
      'date': '22 Sep 2026',
      'status': 'Published',
      'icon': Icons.sports_esports_outlined,
    },
    {
      'title': 'Marvel Universe Latest News',
      'fandom': 'Marvel',
      'author': 'Admin',
      'date': '21 Sep 2026',
      'status': 'Pending',
      'icon': Icons.flash_on_outlined,
    },
    {
      'title': 'K-Pop Fandom Highlights',
      'fandom': 'K-Pop',
      'author': 'Kanwal',
      'date': '20 Sep 2026',
      'status': 'Published',
      'icon': Icons.music_video_outlined,
    },
  ];

  List<Map<String, dynamic>> filteredPosts = [];

  @override
  void initState() {
    super.initState();
    filteredPosts = List.from(posts);
  }

  void searchPosts(String value) {
    setState(() {
      filteredPosts = posts.where((post) {
        final title = post['title'].toString().toLowerCase();
        final fandom = post['fandom'].toString().toLowerCase();
        final search = value.toLowerCase();

        return title.contains(search) || fandom.contains(search);
      }).toList();
    });
  }

  void showCreatePostDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFF0D1230),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(
              color: Color(0xFF6652C9),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create New Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Create a new fandom post',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 22),

                  _dialogField(
                    controller: titleController,
                    label: 'Post Title',
                    hint: 'Enter post title',
                  ),

                  const SizedBox(height: 15),

                  _dialogField(
                    controller: contentController,
                    label: 'Post Content',
                    hint: 'Write your post...',
                    maxLines: 4,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Post created successfully!',
                              ),
                              backgroundColor: Color(0xFF754DFF),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF754DFF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Create Post'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _dialogField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.35),
            ),
            filled: true,
            fillColor: const Color(0xFF080D25),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Color(0xFF4D4A86),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Color(0xFF4D4A86),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Color(0xFF9A67FF),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0D1230),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Delete Post?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this post?',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white60),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final post = filteredPosts[index];
                  posts.remove(post);
                  filteredPosts.removeAt(index);
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Post deleted'),
                    backgroundColor: Color(0xFFE84D7A),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE84D7A),
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05021A),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fandom_background.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.35),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                22,
                20,
                22,
                35,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _topBar(),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Post Management',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Manage and organize fandom posts',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 15),

                      ElevatedButton.icon(
                        onPressed: showCreatePostDialog,
                        icon: const Icon(
                          Icons.add_rounded,
                          size: 20,
                        ),
                        label: const Text('New Post'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFF754DFF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  _searchBar(),

                  const SizedBox(height: 25),

                  _summarySection(),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'All Posts',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${filteredPosts.length} posts',
                        style: const TextStyle(
                          color: Color(0xFFB47AFF),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount =
                      constraints.maxWidth > 900
                          ? 3
                          : constraints.maxWidth > 600
                          ? 2
                          : 1;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        itemCount: filteredPosts.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1.18,
                        ),
                        itemBuilder: (context, index) {
                          return _postCard(
                            filteredPosts[index],
                            index,
                          );
                        },
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

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF111637),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFF6652C9),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(width: 13),

            Image.asset(
              'assets/images/fandom_logo_clean.png',
              width: 115,
              height: 55,
              fit: BoxFit.contain,
            ),
          ],
        ),

        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF111637),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF6652C9),
            ),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFF0B1231).withOpacity(0.95),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFF6650BD),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7A4DFF).withOpacity(0.16),
            blurRadius: 16,
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        onChanged: searchPosts,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search posts or fandoms...',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.40),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFFB16DFF),
          ),
          suffixIcon: const Icon(
            Icons.filter_list_rounded,
            color: Color(0xFF765CFF),
          ),
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _summarySection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount =
        constraints.maxWidth > 700 ? 3 : 1;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio:
          constraints.maxWidth > 700 ? 2.6 : 3.2,
          children: [
            _summaryCard(
              title: 'Total Posts',
              value: '126',
              icon: Icons.article_outlined,
              iconColor: const Color(0xFF9B6CFF),
            ),
            _summaryCard(
              title: 'Published',
              value: '98',
              icon: Icons.check_circle_outline_rounded,
              iconColor: const Color(0xFF45E6A5),
            ),
            _summaryCard(
              title: 'Pending',
              value: '28',
              icon: Icons.pending_actions_rounded,
              iconColor: const Color(0xFFFFC857),
            ),
          ],
        );
      },
    );
  }

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1333).withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF504D91),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF714DFF).withOpacity(0.12),
            blurRadius: 18,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 25,
            ),
          ),

          const SizedBox(width: 13),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _postCard(
      Map<String, dynamic> post,
      int index,
      ) {
    final bool published =
        post['status'] == 'Published';

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1333).withOpacity(0.96),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF504D91),
        ),
        boxShadow: [
          BoxShadow(
            color:
            const Color(0xFF714DFF).withOpacity(0.13),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF4FD8),
                      Color(0xFF784DFF),
                      Color(0xFF19DFFF),
                    ],
                  ),
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                child: Icon(
                  post['icon'],
                  color: Colors.white,
                  size: 24,
                ),
              ),

              PopupMenuButton<String>(
                color: const Color(0xFF111637),
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white54,
                ),
                onSelected: (value) {
                  if (value == 'edit') {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Edit Post UI coming soon!',
                        ),
                        backgroundColor:
                        Color(0xFF754DFF),
                      ),
                    );
                  }

                  if (value == 'delete') {
                    showDeleteDialog(index);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 19,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline_rounded,
                          color: Color(0xFFFF6B8A),
                          size: 19,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),

          Text(
            post['title'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(
                Icons.category_outlined,
                color: Color(0xFFB17AFF),
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                post['fandom'],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 11,
                ),
              ),
            ],
          ),

          const Spacer(),

          Row(
            children: [
              const Icon(
                Icons.person_outline_rounded,
                color: Colors.white38,
                size: 15,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  post['author'],
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                  ),
                ),
              ),
              Text(
                post['date'],
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 9,
                ),
              ),
            ],
          ),

          const SizedBox(height: 11),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: published
                      ? const Color(0xFF45E6A5)
                      .withOpacity(0.12)
                      : const Color(0xFFFFC857)
                      .withOpacity(0.12),
                  borderRadius:
                  BorderRadius.circular(20),
                ),
                child: Text(
                  post['status'],
                  style: TextStyle(
                    color: published
                        ? const Color(0xFF45E6A5)
                        : const Color(0xFFFFC857),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color:
                  const Color(0xFF754DFF)
                      .withOpacity(0.15),
                  borderRadius:
                  BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xFFB47AFF),
                  size: 17,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}