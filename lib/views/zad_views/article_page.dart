import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/api/article_api.dart';
import 'package:mulabbi/models/article_model.dart';

class ArticlePage extends StatefulWidget {
  final String topicTitle;

  const ArticlePage({super.key, required this.topicTitle});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  ArticleModel? selectedArticle;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadArticle();
  }

  Future<void> loadArticle() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final article = await ArticleService.fetchArticleByTitle(
        widget.topicTitle,
      );

      setState(() {
        selectedArticle = article;
        isLoading = false;
        if (article == null) {
          errorMessage = "المقال غير موجود";
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "حدث خطأ في تحميل المقال";
      });
      print('Error loading article: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6EEE4),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFAE7D56)),
      );
    }

    if (errorMessage != null) {
      return _buildErrorWidget();
    }

    if (selectedArticle == null) {
      return _buildErrorWidget(message: "المقال غير موجود");
    }

    return _buildArticleContent();
  }

  Widget _buildErrorWidget({String? message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message ?? errorMessage ?? "حدث خطأ غير متوقع",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontFamily: 'Cairo',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: loadArticle,
            icon: const Icon(Icons.refresh),
            label: const Text("إعادة المحاولة"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFAE7D56),
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              "العودة",
              style: TextStyle(color: Color(0xFFAE7D56), fontFamily: 'Cairo'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleContent() {
    final imagePath = _getImagePath();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildHeader(context, imagePath, selectedArticle!.title ?? ''),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [..._buildSections()],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getImagePath() {
    if (selectedArticle?.imageUrl != null &&
        selectedArticle!.imageUrl!.isNotEmpty) {
      final firstImage = selectedArticle!.imageUrl![0];
      if (firstImage.startsWith('http')) {
        return firstImage;
      }
    }
    return 'assets/images/zad_main.png';
  }

  List<Widget> _buildSections() {
    if (selectedArticle?.subTitleContents == null) {
      return [
        const Text(
          "لا يوجد محتوى متاح",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: 'Cairo',
          ),
        ),
      ];
    }

    return List.generate(selectedArticle!.subTitleContents!.length, (index) {
      final section = selectedArticle!.subTitleContents![index];
      final sectionTitle =
          (selectedArticle!.subTitles != null &&
                  index < selectedArticle!.subTitles!.length)
              ? selectedArticle!.subTitles![index]
              : null;

      return Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sectionTitle != null)
              _buildSectionTitle(sectionTitle, index + 1),
            const SizedBox(height: 12),
            _buildSection(section),
          ],
        ),
      );
    });
  }

  Widget _buildSectionTitle(String title, int sectionNumber) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFAE7D56).withOpacity(0.1),
            const Color(0xFFAE7D56).withOpacity(0.05),
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          right: BorderSide(color: Color(0xFFAE7D56), width: 4),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFAE7D56),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$sectionNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              maxLines: 3,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFAE7D56),
                fontFamily: 'Cairo',
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String imagePath, String title) {
    return SizedBox(
      height: 350,
      child: Stack(
        children: [
          _buildImageContainer(imagePath),
          _buildGradientOverlay(),
          _buildTitleOverlay(context, title),
          _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      width: double.infinity,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        image: DecorationImage(
          image:
              imagePath.startsWith('http')
                  ? NetworkImage(imagePath)
                  : AssetImage(imagePath) as ImageProvider,
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            print('Error loading image: $exception');
          },
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      width: double.infinity,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            const Color(0xFF7E5A3B).withOpacity(0.8),
            const Color(0xFF7E5A3B).withOpacity(0.4),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildTitleOverlay(BuildContext context, String title) {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          title,
          maxLines: 3,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 40,
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
            height: 1.3,
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 20,
      left: 16,
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color.fromARGB(255, 255, 255, 255),
          size: 30,
        ),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _buildSection(SubTitleContents section) {
    if (section.paragraphs == null || section.paragraphs!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children:
          section.paragraphs!
              .map<Widget>((para) => _buildParagraph(para))
              .toList(),
    );
  }

  Widget _buildParagraph(Paragraphs para) {
    final text = para.text ?? '';
    final type = para.type ?? 'text';

    if (text.isEmpty) return const SizedBox.shrink();

    switch (type) {
      case 'ayah':
        return _buildAyahContainer(text);
      case 'hadith':
        return _buildHadithContainer(text);
      case 'text':
      default:
        return _buildTextParagraph(text);
    }
  }

  Widget _buildAyahContainer(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.green.shade100],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        border: Border.all(color: Colors.green.shade200, width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                " قال تعالى",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 17,
              fontStyle: FontStyle.italic,
              color: Colors.green.shade800,
              fontFamily: 'Cairo',
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildHadithContainer(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.orange.shade100],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        border: Border.all(color: Colors.orange.shade200, width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.format_quote,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "عن الرسول",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 17,
              fontStyle: FontStyle.italic,
              color: Colors.orange.shade800,
              fontFamily: 'Cairo',
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildTextParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text.tr,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Cairo',
          height: 1.7,
          color: Color(0xFF2C2C2C),
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
