import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/core/themes/app_colors.dart';
import 'package:metro_city_pulse/presentation/utils/navigation_util.dart';
import 'package:metro_city_pulse/presentation/widgets/buttons/app_text_button.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppListDialog<T> extends HookConsumerWidget {

  final List<T> items;
  final Widget Function(T, int, bool)? displayBuilder;
  final Widget Function(T, int, bool)? separatorBuilder;
  final String Function(T)? getTextFromItem;
  final Function(T) onItemSelected;
  final String? heading;
  final int initialSelectedIndex;
  final String? confirmBtnText;
  final String? cancelBtnText;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final double? posLeft;
  final double? posRight;
  final double? posTop;
  final double? posBottom;
  final double headingTextSize;

  const AppListDialog({super.key, required this.items,
    required this.onItemSelected,
    this.heading,
    this.displayBuilder,
    this.separatorBuilder,
    this.confirmBtnText,
    this.cancelBtnText,
    this.getTextFromItem,
    this.initialSelectedIndex = 0,
    this.width,
    this.height,
    this.padding = EdgeInsets.zero,
    this.posLeft,
    this.posRight,
    this.posTop,
    this.posBottom,
    this.headingTextSize = 17.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appThemeStateProvider).colors;
    final selectedIndex = useState(initialSelectedIndex);
    return GestureDetector(
     // key: const Key(AppListDialogKeys.outsideClickKey),
      onTap: () {
        NavigationUtil.pop(context);
      },
      child: Material(
        color: colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: posLeft,
              right: posRight,
              top: posTop,
              bottom: posBottom,
              child: Container(
               // key: const Key(AppListDialogKeys.containerKey),
                width: width,
                height: height,
                padding: padding,
                decoration: BoxDecoration(
                  color: colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                 // key: const Key(AppListDialogKeys.columnKey),
                  children: [
                    heading != null ? AppText(heading!,
                      //key: const Key(AppListDialogKeys.headingKey),
                      size: headingTextSize,
                      fontWeight: FontWeight.w700,
                      color: colors.black,
                      textAlign: TextAlign.center,
                    ) : const SizedBox(),
                    SizedBox(height: heading != null ? 15 : 0,),
                    heading != null ? Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          color: colors.defaultBlueColor
                      ),
                    ): const SizedBox(),
                    SizedBox(height: heading != null ? 30 : 0,),
                    Expanded(child: ListView.separated(
                       // key: const Key(AppListDialogKeys.listViewKey),
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return InkWell(
                            //key: Key("${KDListDialogKeys.listViewItemKey}_$index"),
                            onTap: () {
                              // if no confirm button, directly call on item selected
                              if (confirmBtnText == null) {
                                _onSuccess(context, index);
                              } else {
                                selectedIndex.value = index; // if confirm button is present just item as selected
                              }
                            },
                            child: displayBuilder?.call(items[index], index, selectedIndex.value == index)
                                ?? _defaultBuilder(items[index], index, selectedIndex.value == index, colors),
                          );
                        },
                        separatorBuilder: (ctx, index) => separatorBuilder?.call(items[index], index, selectedIndex.value == index) ?? const SizedBox(height: 15,),
                        itemCount: items.length)),
                    SizedBox(height: confirmBtnText != null ? 30 : 0,),
                    confirmBtnText != null
                        ? AppTextButton(
                             // key: const Key(AppListDialogKeys.confirmBtnKey),
                              text: confirmBtnText!.toUpperCase(),
                              height: 44,
                              onPressed: () {
                                _onSuccess(context, selectedIndex.value);
                            },)
                        : const SizedBox(),
                    SizedBox(height: cancelBtnText != null ? 10 : 0,),
                    cancelBtnText != null ? AppTextButton(text: cancelBtnText!.toUpperCase(),
                      //key: const Key(AppListDialogKeys.cancelBtnKey), 
                      onPressed: () {
                      NavigationUtil.pop(context);
                    }, color: colors.black,
                      size: 14,
                      fontWeight: FontWeight.w600,

                    ) : const SizedBox()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTextFromItem(T item) => item.toString();

  Widget _defaultBuilder(T item, int index, bool isSelected, AppColors colors) {
    return SizedBox(
        width: 200,
      child: Row(
        children: [
          _getIcon(isSelected, colors),
          const SizedBox(width: 10,),
          Expanded(child: AppText(getTextFromItem?.call(item) ?? _getTextFromItem(item),
           // key: const Key(AppListDialogKeys.listViewItemTextKey),
            size: 15,
            fontWeight: FontWeight.w400,
            color: colors.black,
          )
          ),
        ],
      ),
    );
  }
  
  Widget _getIcon(bool isSelected, AppColors colors) {
    return Container(
      //key: const Key(AppListDialogKeys.listViewItemIconKey),
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: isSelected ? colors.defaultBlueColor : colors.transparent,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: isSelected ? colors.defaultBlueColor : colors.unSelectedColor)
      ),
    );
  }

  void _onSuccess(BuildContext context, int index) {
    NavigationUtil.pop(context);
    onItemSelected.call(items[index]);
  }
}