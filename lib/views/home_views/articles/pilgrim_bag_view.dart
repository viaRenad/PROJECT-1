import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/widgets/home_widgets/article_section_card.dart';

class PilgrimBagView extends StatefulWidget {
  const PilgrimBagView({super.key});

  @override
  State<PilgrimBagView> createState() => _PilgrimBagViewState();
}

class _PilgrimBagViewState extends State<PilgrimBagView> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
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
          color: const Color(0xFFF5F2EE).withOpacity(_appBarOpacity),
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
                  'assets/images/pilgrim_bag.png', // change to your actual image path
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
                    'لراحة وتنظيم أفضل\nهذه محتويات حقيبتك',
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
                  title: 'ملابس الإحرام والراحة',
                  items: [
                    'لباس إحرام قماشي خفيف (ويُفضل إحضار طقمين لتبديله عند الحاجة)',
                    'رداء داخلي قطني مريح وخفيف',
                    'شبشب بسيط يناسب الطواف والسعي ولا يغطي الكعبين',
                    'ثوب إضافي للخروج أو التنقل داخل السكن أو عند الطوارئ',
                  ],
                ),
                ArticleSectionCard(
                  number: 2,
                  title: 'لوازم النظافة والعناية الشخصية',
                  items: [
                    'فرشاة ومعجون أسنان',
                    'صابون وشامبو خالٍ من العطور (موافق عليه أثناء الإحرام)',
                    'مناديل مبللة وجافة',
                    'مقص أظافر صغير ومشط للشعر',
                    'فوط صحية أو مناديل خاصة للنساء',
                    'مناشف قطنية صغيرة',
                  ],
                ),
                ArticleSectionCard(
                  number: 3,
                  title: 'المستلزمات الطبية والوقائية',
                  items: [
                    'كمامات طبية ومعقم يدين (يفضل الحجم الصغير للسفر)',
                    'أدوية منتظمة أو خاصة بالحالة الصحية مع وصفة طبية عند الحاجة',
                    'لاصقات للجروح وأدوية للمعدة أو الحساسية أو الصداع',
                    'كريم واقٍ من الشمس (مسموح بدون عطر)',
                  ],
                ),
                ArticleSectionCard(
                  number: 4,
                  title: 'أدوات مريحة للتنقل والاستخدام اليومي',
                  items: [
                    'حقيبة ظهر صغيرة لحمل الأساسيات اليومية داخل الحرم',
                    'زجاجة ماء قابلة لإعادة التعبئة (محافظة على الحرارة/البرودة)',
                    'مظلة شمسية خفيفة ومريحة',
                    'وسادة رقبة أو وسادة صغيرة للنوم في الباص أو الانتظار',
                  ],
                ),
                ArticleSectionCard(
                  number: 5,
                  title: 'أغراض مساعدة للعبادة والتوثيق',
                  items: [
                    'دفتر صغير وقلم لتدوين الملاحظات أو الأدعية',
                    'نسخة جيب من المصحف أو تطبيق معتمد على الهاتف',
                    'خريطة للمشاعر المقدسة أو تطبيق ملاحي',
                    'بطارية متنقلة (Power Bank) وشاحن للهاتف',
                  ],
                ),
                ArticleSectionCard(
                  number: 6,
                  title: 'نصائح عامة للتجهيز الذكي',
                  items: [
                    'يفضل تقسيم الحقيبة إلى أكياس مخصصة (ملابس، أدوات نظافة، أدوية)',
                    'تجربة وزن الحقيبة مسبقاً لتفادي الوزن الزائد بالمطار',
                    'عدم حمل مبالغ مالية كبيرة، والاستعانة ببطاقة بنكية دولية',
                    'إضافة بطاقة تعريفية داخل الحقيبة تحتوي على بياناتك ومقر السكن',
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
