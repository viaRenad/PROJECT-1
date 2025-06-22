import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/main.dart';
import 'package:mulabbi/views/zad_views/article_page.dart';
import 'package:mulabbi/widgets/zad_widgets/category_widget.dart';
import 'package:mulabbi/widgets/zad_widgets/topic_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

  int? selectedCategoryId;
  String? selectedCategoryTitle;
  List<Map<String, dynamic>> selectedTopics = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTopics();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6EEE4),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(),
            buildSearchBar(),
            sectionTitle('تصفح زاد حسب الفئة'),
            buildCategoryRow(),

            sectionTitle('تعرف على مناسك الحج ومقاصده'),
            buildTopicSection(hajjTopics),
            sectionTitle('دليلك للعمرة'),
            buildTopicSection(umrahTopics),
            sectionTitle('استعدّ روحياً لرحلة الحج العظيمة'),
            buildTopicSection(healthyTopics),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Stack(
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
          left: 250,
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
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CategoryWidget(
              title: 'الصحة والسلامة',
              imagePath: 'assets/images/zad_main.png',
              onTap: () {},
            ),
            CategoryWidget(
              title: 'الحج',
              imagePath: 'assets/images/zad_main.png',
              onTap: () {},
            ),
            CategoryWidget(
              title: 'العمرة',
              imagePath: 'assets/images/zad_main.png',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (topics.isEmpty) {
      return const Center(child: Text('لا توجد مواضيع حالياً'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: List.generate(topics.length, (index) {
          final item = topics[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TopicWidget(
              topicTitle: item['title'] ?? '',
              imagePath: item['image_url'] ?? 'assets/images/zad_main.png',
              Category: item['category']['title'],
              // لازم يعرض مواضيع الصفحات
              onTap: () {
                final topicTitle = item['title']; // أو 'title' حسب العمود عندك
                Get.to(() => ArticlePage(topicTitle: topicTitle));
              },
            ),
          );
        }),
      ),
    );
  }
}
