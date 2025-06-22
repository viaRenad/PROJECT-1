import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/widgets/home_widgets/article_section_card.dart';

class OfficialDocumentsView extends StatefulWidget {
  const OfficialDocumentsView({super.key});

  @override
  State<OfficialDocumentsView> createState() => _OfficialDocumentsViewState();
}

class _OfficialDocumentsViewState extends State<OfficialDocumentsView> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double offset = _scrollController.offset;

      // AppBar starts fading in after 400px, fully visible at 480px
      const double bannerHeight = 300;
      const double fadeHeight = 90;

      double newOpacity = (offset - bannerHeight + fadeHeight) / fadeHeight;

      if (newOpacity != _appBarOpacity) {
        setState(() {
          _appBarOpacity = newOpacity.clamp(0.0, 1.0);
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F2EE),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: const Color(
            0xFFF5F2EE,
          ).withOpacity(_appBarOpacity), // Dusty Sand tone

          padding: const EdgeInsets.only(left: 12, top: 8),
          child: SafeArea(
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Color(0xFF6A370B),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(0),
        children: [
          // ✅ Banner
          Container(
            width: double.infinity,
            height: 400,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Image.asset(
                  'assets/images/official_docs.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: AppColorBrown.brownArticleOverlay,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 50, right: 40),
                  child: Text(
                    'لرحلة دون عوائق\nإليك أهم الوثائق الرسمية',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.5,
                      fontFamily: 'Cairo',
                      shadows: [
                        Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.33),
                          offset: Offset(0, 4),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ArticleSectionCard(
                  number: 1,
                  title: 'جواز السفر',
                  items: [
                    'يجب أن يكون جواز السفر ساري المفعول لمدة لا تقل عن 6 أشهر من تاريخ السفر',
                    'يفضل أن يحتوي على صفحتين فارغتين على الأقل',
                    'بالنسبة للحجاج المصريين، يجب أن يكون الجواز مميكنًا',
                  ],
                ),
                ArticleSectionCard(
                  number: 2,
                  title: 'تأشيرة الحج أو العمرة',
                  items: [
                    'يجب الحصول على التأشيرة من خلال وكالات السفر المعتمدة من قبل وزارات الحج والعمرة السعودية',
                    'يمنع أداء مناسك الحج أو العمرة بتأشيرة سياحية',
                  ],
                ),
                ArticleSectionCard(
                  number: 3,
                  title: 'شهادة التطعيمات',
                  items: [
                    'شهادة تطعيم ضد الالتهاب السحائي (اللقاح الرباعي ACYW135) صادرة قبل السفر بمدة لا تقل عن 10 أيام ولا تزيد عن 3 سنوات',
                    'شهادة تطعيم ضد الحمى الشوكية أو شلل الأطفال أو الإنفلونزا، حسب الوجهة أو الحالة الصحية',
                  ],
                ),
                ArticleSectionCard(
                  number: 4,
                  title: 'الصور الشخصية',
                  items: [
                    'صورتان حديثتان ملونتان بحجم 2x2 بوصة، بخلفية بيضاء، وتعبير وجه محايد',
                    'يُمنع ارتداء النظارات أو غطاء الرأس، إلا لأسباب دينية',
                  ],
                ),
                ArticleSectionCard(
                  number: 5,
                  title: 'إثبات العلاقة (للسيدات والأطفال)',
                  items: [
                    'يجب تقديم عقد زواج أو شهادة ميلاد لإثبات العلاقة مع المحرم',
                    'النساء دون 45 عامًا لا يمكنهن أداء الحج أو العمرة بدون محرم، يشترط السفر مع مجموعة منظمة تقدم خطاب عدم ممانعة من الزوج أو الأب',
                  ],
                ),
                ArticleSectionCard(
                  number: 6,
                  title: 'تذكرة السفر',
                  items: ['تذكرة سفر ذهاب وعودة مؤكدة'],
                ),
                ArticleSectionCard(
                  number: 7,
                  title: 'تصريح الحج أو العمرة',
                  items: [
                    'يجب الحصول على تصريح الحج أو العمرة من خلال التطبيقات الرسمية مثل "توكلنا" أو "نسك"',
                    'يمنع أداء المناسك بدون تصريح رسمي',
                  ],
                ),
                ArticleSectionCard(
                  number: 8,
                  title: 'وثائق إضافية (حسب الدولة)',
                  items: [
                    'شهادة تحركات من الإدارة العامة للجوازات والهجرة والجنسية',
                    'تصريح من جهة العمل إذا كان الحاج موظفًا',
                    'صحيفة حالة جنائية مميكنة',
                    'ما يوضح الموقف التجنيدي للذكور في سن التجنيد',
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
