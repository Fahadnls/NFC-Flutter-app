import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBack;
  final bool showSearch;
  final bool showCart;
  final Widget actionWidget;
  final VoidCallback? onBackPressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onCartPressed;
  final bool showCartBadge;
  final int cartBadgeCount;

  const CommonAppBar({
    super.key,
    this.title,
    this.showBack = true,
    this.showSearch = true,
    this.showCart = true,
    this.onBackPressed,
    this.onSearchPressed,
    this.onCartPressed,
    this.actionWidget = const SizedBox.shrink(),
    this.showCartBadge = false,
    this.cartBadgeCount = 0,
  });

  void _openCart() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return AppBar(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      leading: showBack
          ? IconButton(
              icon: Transform.flip(
                flipX: isRtl,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              onPressed: onBackPressed ?? () => Get.back(),
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 22,
                fontFamily: Theme.of(
                  context,
                ).textTheme.displaySmall?.fontFamily,
              ),
            )
          : null,
      actions: [
        if (showSearch)
          IconButton(
            icon: Icon(
              Icons.search,
              size: 24,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: onSearchPressed,
          ),
        if (showSearch && showCart) const SizedBox(width: 4),
        if (showCart)
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 24,
                  color: theme.colorScheme.onSurface,
                ),
                if (showCartBadge && cartBadgeCount > 0)
                  Positioned(
                    right: -5,
                    top: -5,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Center(
                        child: Text(
                          cartBadgeCount > 99 ? '99+' : '$cartBadgeCount',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: onCartPressed ?? _openCart,
          ),
        actionWidget,
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
