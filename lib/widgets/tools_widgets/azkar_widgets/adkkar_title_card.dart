import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/models/adhkar_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mulabbi/widgets/tools_widgets/azkar_widgets/adhkar_content_card.dart';

class TitleCard extends StatefulWidget {
  final String title;
  final bool isExpanded;
  final List<ContentItem> adhkar;

  const TitleCard({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.adhkar,
  });

  static const boxColor = AppColorBrown.carfBrown;
  @override
  _TitleCardState createState() => _TitleCardState();
}

class _TitleCardState extends State<TitleCard> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main card
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              gradient: TitleCard.boxColor,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 🡐 Arrow on the left
                Icon(
                  _isExpanded
                      ? Icons.arrow_drop_down_outlined
                      : Icons.arrow_right,
                  color: Colors.white,
                  size: 24,
                ),

                // 🡒 Title on the right
                Text(
                  widget.title,
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.w600, // Regular
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ),

        // Expanded content
        if (_isExpanded && widget.adhkar.isNotEmpty) ...[
          SizedBox(height: 12),
          ...widget.adhkar.map((adhkar) => ContentItemCard(adhkarItem: adhkar)),
        ],
      ],
    );
  }
}
