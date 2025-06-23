import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2EE),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: AppColorBrown.gradientBrown,
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            title: const Text(
              'سياسة الشروط والاحكام',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'مرحبًا بك في تطبيق مُلبي',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A370B),
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 12),
                Text(
                  '''من خلال استخدامك للتطبيق فإنك توافق على الشروط التالية:

1. يُسمح باستخدام التطبيق للاستخدام الشخصي فقط، ويُمنع استخدامه لأي أغراض تجارية أو ترويجية أو في أي نشاط يُخالف الشريعة الإسلامية أو الأنظمة المعمول بها في المملكة العربية السعودية.

2. تُقدَّم المعلومات في هذا التطبيق لأغراض الإرشاد العام فقط، ولا يُعتَمد عليها كمرجع شرعي نهائي. نوصي بالرجوع إلى العلماء المختصين في المسائل الفقهية المعقدة.

3. تقع على عاتقك مسؤولية حماية بيانات حسابك وعدم مشاركتها مع أي شخص آخر، ويجب إبلاغنا فورًا في حال حدوث أي خرق أمني أو محاولة دخول غير مصرّح بها.

4. يُمنع نسخ أو إعادة نشر أو توزيع أي جزء من محتوى التطبيق دون الحصول على إذن كتابي مُسبق من الجهة المالكة للتطبيق.

5. يُعد التطبيق أداة مساعدة وإرشادية، ولا يُغني عن المرشدين المعتمدين في رحلات الحج والعمرة، كما لا يُمثل بديلًا عن الاستشارة الطبية في الحالات الطارئة.

6. قد نقوم بتحديث التطبيق أو إيقاف بعض الخدمات مؤقتًا لأغراض الصيانة أو التطوير دون إشعار مُسبق.

7. نحتفظ بحق تعليق أو إيقاف حسابك أو وصولك إلى التطبيق في حال مخالفة شروط الاستخدام أو إساءة استخدام المحتوى أو الخدمات.

8. نلتزم بحماية خصوصية معلوماتك الشخصية، ولن نُشاركها مع أي طرف ثالث إلا في الحالات التي يتطلبها النظام أو بموافقة صريحة من المستخدم.

9. تخضع هذه الشروط لأحكام القوانين المعمول بها في المملكة العربية السعودية، ويجوز تعديلها في أي وقت، وسيتم إشعار المستخدمين بذلك من خلال التطبيق أو وسائل الاتصال الرسمية.''',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    height: 1.9,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
