import 'package:flutter/material.dart';

class AdminReports extends StatefulWidget {
  const AdminReports({super.key});

  @override
  State<AdminReports> createState() => _AdminReportsState();
}

class _AdminReportsState extends State<AdminReports> {
  String selectedPeriod = 'This Month';

  final List<Map<String, dynamic>> reportData = [
    {
      'title': 'Total Users',
      'value': '2,840',
      'change': '+12.5%',
      'icon': Icons.people_outline_rounded,
    },
    {
      'title': 'Total Posts',
      'value': '1,264',
      'change': '+8.4%',
      'icon': Icons.article_outlined,
    },
    {
      'title': 'Fandoms',
      'value': '48',
      'change': '+4.2%',
      'icon': Icons.auto_awesome_outlined,
    },
    {
      'title': 'Active Users',
      'value': '1,920',
      'change': '+15.7%',
      'icon': Icons.person_outline_rounded,
    },
  ];

  final List<Map<String, dynamic>> fandomStats = [
    {
      'name': 'Music',
      'fans': '32.4K',
      'percentage': 0.88,
      'icon': Icons.music_note_rounded,
    },
    {
      'name': 'Movies',
      'fans': '24.8K',
      'percentage': 0.72,
      'icon': Icons.movie_outlined,
    },
    {
      'name': 'Gaming',
      'fans': '21.9K',
      'percentage': 0.64,
      'icon': Icons.sports_esports_outlined,
    },
    {
      'name': 'Anime',
      'fans': '18.6K',
      'percentage': 0.54,
      'icon': Icons.auto_awesome_outlined,
    },
  ];

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
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                22,
                18,
                22,
                35,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _topBar(),

                  const SizedBox(height: 28),

                  _header(),

                  const SizedBox(height: 24),

                  _periodSelector(),

                  const SizedBox(height: 22),

                  _statisticsGrid(),

                  const SizedBox(height: 28),

                  _sectionTitle(
                    'Fandom Performance',
                    'Popular fandom activity',
                  ),

                  const SizedBox(height: 15),

                  _fandomPerformance(),

                  const SizedBox(height: 28),

                  _sectionTitle(
                    'Activity Overview',
                    'Platform activity summary',
                  ),

                  const SizedBox(height: 15),

                  _activityChart(),

                  const SizedBox(height: 28),

                  _sectionTitle(
                    'Recent Reports',
                    'Latest platform activity',
                  ),

                  const SizedBox(height: 15),

                  _recentReports(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= TOP BAR =================

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

            const SizedBox(width: 12),

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

  // ================= HEADER =================

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reports & Analytics',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Monitor your Fandom platform performance',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),

        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF754DFF).withOpacity(0.15),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: const Color(0xFF754DFF),
            ),
          ),
          child: const Icon(
            Icons.download_outlined,
            color: Color(0xFFB47AFF),
          ),
        ),
      ],
    );
  }

  // ================= PERIOD =================

  Widget _periodSelector() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1333).withOpacity(0.95),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF504D91),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedPeriod,
          isExpanded: true,
          dropdownColor: const Color(0xFF111637),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFFB47AFF),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          items: const [
            DropdownMenuItem(
              value: 'Today',
              child: Text('Today'),
            ),
            DropdownMenuItem(
              value: 'This Week',
              child: Text('This Week'),
            ),
            DropdownMenuItem(
              value: 'This Month',
              child: Text('This Month'),
            ),
            DropdownMenuItem(
              value: 'This Year',
              child: Text('This Year'),
            ),
          ],
          onChanged: (value) {
            if (value == null) return;

            setState(() {
              selectedPeriod = value;
            });
          },
        ),
      ),
    );
  }

  // ================= STATISTICS =================

  Widget _statisticsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int columns = constraints.maxWidth > 800 ? 4 : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reportData.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 13,
            mainAxisSpacing: 13,
            childAspectRatio: 1.45,
          ),
          itemBuilder: (context, index) {
            final item = reportData[index];

            return _statCard(
              title: item['title'].toString(),
              value: item['value'].toString(),
              change: item['change'].toString(),
              icon: item['icon'] as IconData,
            );
          },
        );
      },
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required String change,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1333).withOpacity(0.96),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF504D91),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF754DFF).withOpacity(0.12),
            blurRadius: 18,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color:
                  const Color(0xFF754DFF).withOpacity(0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFFB47AFF),
                  size: 20,
                ),
              ),

              Text(
                change,
                style: const TextStyle(
                  color: Color(0xFF45E6A5),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.52),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // ================= SECTION TITLE =================

  Widget _sectionTitle(
      String title,
      String subtitle,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // ================= FANDOM PERFORMANCE =================

  Widget _fandomPerformance() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1333).withOpacity(0.96),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF504D91),
        ),
      ),
      child: Column(
        children: fandomStats.map((fandom) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: _fandomRow(fandom),
          );
        }).toList(),
      ),
    );
  }

  Widget _fandomRow(
      Map<String, dynamic> fandom,
      ) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF4FD8),
                    Color(0xFF784DFF),
                  ],
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                fandom['icon'] as IconData,
                color: Colors.white,
                size: 19,
              ),
            ),

            const SizedBox(width: 11),

            Expanded(
              child: Text(
                fandom['name'].toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Text(
              '${fandom['fans']} fans',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
              ),
            ),
          ],
        ),

        const SizedBox(height: 9),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: fandom['percentage'] as double,
            minHeight: 6,
            backgroundColor:
            Colors.white.withOpacity(0.07),
            valueColor:
            const AlwaysStoppedAnimation<Color>(
              Color(0xFF875CFF),
            ),
          ),
        ),
      ],
    );
  }

  // ================= ACTIVITY CHART =================

  Widget _activityChart() {
    final values = [
      0.35,
      0.52,
      0.42,
      0.68,
      0.58,
      0.82,
      0.74,
    ];

    const days = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    return Container(
      height: 220,
      padding: const EdgeInsets.fromLTRB(
        18,
        20,
        18,
        15,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1333).withOpacity(0.96),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF504D91),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.end,
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              children: values.map((value) {
                return _chartBar(value);
              }).toList(),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: days.map((day) {
              return Text(
                day,
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 9,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _chartBar(double value) {
    return FractionallySizedBox(
      heightFactor: value,
      child: Container(
        width: 22,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFF754DFF),
              Color(0xFFB16DFF),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color:
              const Color(0xFF754DFF).withOpacity(0.25),
              blurRadius: 10,
            ),
          ],
        ),
      ),
    );
  }

  // ================= RECENT REPORTS =================

  Widget _recentReports() {
    final reports = [
      {
        'title': 'New users joined',
        'value': '+124',
        'icon': Icons.person_add_alt_1_outlined,
      },
      {
        'title': 'Posts published',
        'value': '+86',
        'icon': Icons.article_outlined,
      },
      {
        'title': 'Fandom interactions',
        'value': '+1.8K',
        'icon': Icons.favorite_border_rounded,
      },
    ];

    return Column(
      children: reports.map((report) {
        return Container(
          margin: const EdgeInsets.only(bottom: 11),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFF0C1333).withOpacity(0.96),
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: const Color(0xFF504D91),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color:
                  const Color(0xFF754DFF).withOpacity(0.13),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  report['icon'] as IconData,
                  color: const Color(0xFFB47AFF),
                  size: 21,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  report['title'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Text(
                report['value'].toString(),
                style: const TextStyle(
                  color: Color(0xFF45E6A5),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}