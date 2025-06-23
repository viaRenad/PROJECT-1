import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/main.dart';
import 'package:mulabbi/views/zad_views/article_page.dart';
import 'package:mulabbi/widgets/zad_widgets/category_widget.dart';
import 'package:mulabbi/widgets/zad_widgets/topic_widget.dart';
import 'package:get/get.dart';

class ZadPageView extends StatefulWidget {
  const ZadPageView({super.key});

  @override
  State<ZadPageView> createState() => _ZadPageViewState();
}

class _ZadPageViewState extends State<ZadPageView> {
  List<Map<String, dynamic>> hajjTopics = [];
  List<Map<String, dynamic>> umrahTopics = [];
  List<Map<String, dynamic>> healthyTopics = [];

  bool isLoading = true;

  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  int? selectedCategoryId; // 1 = Health, 2 = Hajj, 3 = Umrah

  // Combine all topics into one list for searching
  List<Map<String, dynamic>> get _allTopics => [
    ...healthyTopics,
    ...hajjTopics,
    ...umrahTopics,
  ];

  // Filtered list based on the search query
  List<Map<String, dynamic>> get _filteredTopics =>
      _allTopics
          .where(
            (t) => t['title'].toString().toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ),
          )
          .toList();

  @override
  void initState() {
    super.initState();
    loadTopics();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadTopics() async {
    try {
      final hajj = await fetchTopics(2);
      final umrah = await fetchTopics(3);
      final health = await fetchTopics(1);
      setState(() {
        hajjTopics = hajj;
        umrahTopics = umrah;
        healthyTopics = health;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading topics: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchTopics(int category) async {
    final response = await supabase
        .from('topics')
        .select('*, category(title)')
        .eq('category_id', category);
    return List<Map<String, dynamic>>.from(response);
  }

  void _clearCategory() {
    setState(() {
      selectedCategoryId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2EE),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(),
            const SizedBox(height: 3),
            buildSearchBar(),

            if (_searchQuery.isNotEmpty) ...[
              sectionTitle('نتائج البحث'),
              const SizedBox(height: 10),
              buildTopicSection(_filteredTopics),
            ] else ...[
              sectionTitle('تصفح زاد حسب الفئة'),
              const SizedBox(height: 10),
              buildCategoryRow(),
              const SizedBox(height: 15),

              // If a category is selected, show only that section:
              if (selectedCategoryId != null) ...[
                if (selectedCategoryId == 1) ...[
                  sectionTitle('الصحة والسلامة'),
                  const SizedBox(height: 10),
                  buildTopicSection(healthyTopics),
                ] else if (selectedCategoryId == 2) ...[
                  sectionTitle('تعرف على مناسك الحج ومقاصده'),
                  const SizedBox(height: 10),
                  buildTopicSection(hajjTopics),
                ] else if (selectedCategoryId == 3) ...[
                  sectionTitle('دليلك للعمرة'),
                  const SizedBox(height: 10),
                  buildTopicSection(umrahTopics),
                ],
              ]
              // Otherwise show all three:
              else ...[
                sectionTitle('تعرف على مناسك الحج ومقاصده'),
                const SizedBox(height: 10),
                buildTopicSection(hajjTopics),
                const SizedBox(height: 15),

                sectionTitle('دليلك للعمرة'),
                const SizedBox(height: 10),
                buildTopicSection(umrahTopics),
                const SizedBox(height: 15),

                sectionTitle('استعدّ روحياً لرحلة الحج العظيمة'),
                const SizedBox(height: 10),
                buildTopicSection(healthyTopics),
              ],
            ],

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 423,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/zad_main.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFF7E5A3B).withOpacity(0.6),
                    const Color.fromARGB(0, 126, 90, 59),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            top: 290,
            right: 35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'زاد',
                  style: TextStyle(
                    fontSize: 31,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    shadows: [
                      Shadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
                Text(
                  'استزد علماً',
                  style: TextStyle(
                    fontSize: 31,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    shadows: [
                      Shadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 17.5),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val),
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        cursorColor: const Color(0xFF7E5A3B),
        decoration: InputDecoration(
          hintText: "ابحث في محتوى زاد",
          hintStyle: const TextStyle(
            color: Color(0xFF7E5A3B),
            fontFamily: 'Cairo',
          ),
          filled: true,
          fillColor: const Color.fromARGB(148, 221, 206, 192),
          suffixIcon: const Padding(
            padding: EdgeInsets.all(12),
            child: Icon(Icons.search, color: Color(0xFF7E5A3B)),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: Color(0xFFAE7D56), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: Color(0xFF7E5A3B), width: 1),
          ),
        ),
      ),
    );
  }

  Widget buildCategoryRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: Column(
        children: [
          // 1) The Row containing only your 3 fixed category cards:
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CategoryWidget(
                title: 'الصحة والسلامة',
                imagePath: 'assets/images/healthy.webp',
                heigth: 70,
                width: 150,
                onTap: () => setState(() => selectedCategoryId = 1),
              ),
              CategoryWidget(
                title: 'الحج',
                imagePath: 'assets/images/haj.png',
                heigth: 70,
                width: 200,
                onTap: () => setState(() => selectedCategoryId = 2),
              ),
              CategoryWidget(
                title: 'العمرة',
                imagePath: 'assets/images/Umrah.png',
                heigth: 70,
                width: 190,
                onTap: () => setState(() => selectedCategoryId = 3),
              ),
            ],
          ),

          // 2) Only when a category is selected, show the clear button underneath:
          if (selectedCategoryId != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _clearCategory,
                child: const Text('عرض الكل'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColorBrown.gradientColors.first,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }

  Widget buildTopicSection(List<Map<String, dynamic>> topics) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (topics.isEmpty) {
      return const Center(child: Text('لا توجد مواضيع حالياً'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0),
        child: Row(
          children: List.generate(topics.length, (index) {
            final item = topics[index];
            return TopicWidget(
              topicTitle: item['title'] ?? '',
              imagePath: item['image_url'] ?? 'assets/images/zad_main.png',
              Category: item['category']['title'],
              onTap: () {
                final topicTitle = item['title'];
                Get.to(() => ArticlePage(topicTitle: topicTitle));
              },
            );
          }),
        ),
      ),
    );
  }
}
