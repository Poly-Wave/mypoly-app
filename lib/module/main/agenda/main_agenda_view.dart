import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/module/widget/common/horizontal_padding.dart';
import '../agenda/widget/agenda_topic_card.dart';

@RoutePage()
class MainAgendaView extends HookConsumerWidget {
  const MainAgendaView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color(0xFF0F1F24),

      body: ListView(
        children: [
          HorizontalPadding(
            child: Column(
              children: [_AgendaTopicSection(), _AgendaListSection()],
            ),
          ),
        ],
      ),
    );
  }
}

class _AgendaTopicSection extends StatelessWidget {
  const _AgendaTopicSection();

  @override
  Widget build(BuildContext context) {
    final items = <(String, MPSvgImage)>[
      ('20대\n제일 인기 안건', MPSvgImage(SvgImage.logo, width: 32)),
      ('강남 2동\n제일 인기 안건', MPSvgImage(SvgImage.logo, width: 32)),
      ('오늘 활발하게\n투표중인 안건', MPSvgImage(SvgImage.logo, width: 32)),
    ];

    return SizedBox(
      height: 152,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(top: 16),
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, index) {
          return AgendaTopicCard(item: items[index]);
        },
      ),
    );
  }
}

const sortOptions = ['최신순', '인기순'];
const categoryOptions = ['지역', '주제'];
const fieldOptions = ['주제', '제목', '내용', '썸네일', '등록일자', '조회수', '투표수'];

class _AgendaListSection extends HookConsumerWidget {
  const _AgendaListSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = useState('최신순');
    final category = useState('지역');
    final field = useState('주제');

    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, sort),
          SizedBox(height: 12),
          _buildFilterRow(context, category, field),

          SizedBox(height: 16),

          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (_, __) => Center(
              child: Container(
                width: 320,
                height: 1,
                color: ColorStyles.divider,
              ),
            ),
            itemBuilder: (_, i) {
              return AgendaListItem(
                category: '정책',
                title: '타이틀이 들어올 수 있는 자리입니다.\n그 이상은 말줄임 됩니다.',
                date: '2026.12.31',
                views: 23,
                votes: 999,
                thumbnail: MPSvgImage(SvgImage.logo, width: 64, height: 64),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ValueNotifier<String> sort) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '의안리스트',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ColorStyles.gray10,
          ),
        ),
        GestureDetector(
          onTap: () => _showSheet(context, sortOptions, (v) {
            sort.value = v;
          }),
          child: Row(
            children: [
              Text(
                sort.value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorStyles.gray30,
                ),
              ),
              SizedBox(width: 4),
              MPSvgImage(SvgImage.arrowDown, width: 18),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(
    BuildContext context,
    ValueNotifier<String> category,
    ValueNotifier<String> field,
  ) {
    return Row(
      children: [
        /// AI추천
        Container(
          width: 62,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorStyles.primary50, ColorStyles.primary20],
            ),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'AI추천',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: ColorStyles.primary100,
            ),
          ),
        ),

        SizedBox(width: 8),

        /// 필터 버튼 - 지역/주제
        GestureDetector(
          onTap: () => _showSheet(context, categoryOptions, (v) {
            category.value = v;
          }),
          child: _outlineButton(category.value),
        ),

        SizedBox(width: 8),

        /// 필터 버튼 - 주제/제목/내용/썸네일/등록일자/조회수/투표수
        GestureDetector(
          onTap: () => _showSheet(context, fieldOptions, (v) {
            field.value = v;
          }),
          child: _outlineButton(field.value),
        ),
      ],
    );
  }

  Widget _outlineButton(String label) {
    return Container(
      height: 32,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: ColorStyles.gray20),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorStyles.gray20,
            ),
          ),
          SizedBox(width: 4),
          MPSvgImage(SvgImage.arrowDown, width: 18),
        ],
      ),
    );
  }

  void _showSheet(
    BuildContext context,
    List<String> options,
    Function(String) onSelected,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children: options.map((e) {
            return ListTile(
              title: Text(e),
              onTap: () {
                onSelected(e);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class AgendaListItem extends StatelessWidget {
  final String category;
  final String title;
  final String date;
  final int views;
  final int votes;
  final Widget thumbnail;

  const AgendaListItem({
    super.key,
    required this.category,
    required this.title,
    required this.date,
    required this.views,
    required this.votes,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 카테고리 - '정책'
                    Container(
                      height: 22,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8FFD2),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF373303),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    /// 타이틀
                    SizedBox(
                      width: 244,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12),

              /// 이미지
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(width: 64, height: 64, child: thumbnail),
              ),
            ],
          ),

          SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 날짜
              Text(
                date,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFB2BCC5),
                ),
              ),

              Row(
                children: [
                  /// 조회수
                  MPSvgImage(SvgImage.logo, width: 14.03, height: 9.6),
                  SizedBox(width: 4),
                  Text(
                    views.toString(),
                    style: TextStyle(fontSize: 13, color: Color(0xFFB2BCC5)),
                  ),

                  SizedBox(width: 8),

                  /// 투표수
                  MPSvgImage(SvgImage.logo, width: 16),
                  SizedBox(width: 4),
                  Text(
                    votes.toString(),
                    style: TextStyle(fontSize: 13, color: Color(0xFFB2BCC5)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
