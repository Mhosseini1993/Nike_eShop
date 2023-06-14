import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Models/AuthResultDto.dart';
import 'package:nike/Data/Repos/Auth/AuthRepository.dart';
import 'package:nike/Data/Repos/Cart/CartRepository.dart';
import 'package:nike/Data/Repos/FavoriteProduct/FavoriteProductRepository.dart';
import 'package:nike/Screens/Favorite/FavoriteScreen.dart';
import 'package:nike/Screens/Login/AuthScreen.dart';
import 'package:nike/Screens/OrderHistory/OrderHistoryScreen.dart';
import 'package:nike/gen/assets.gen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<AuthResultDto?>(
          valueListenable: AuthRepository.authChangeNotifier,
          builder: (context, AuthResultDto? value, Widget? child) {
            final isLogin = (value != null && value.refresh_token != null);
            return Column(
              children: [
                const Divider(),
                Container(
                  width: 65,
                  height: 65,
                  margin: const EdgeInsets.only(top: 32, bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  child: Assets.images.nikeLogo.image(),
                ),
                Text((isLogin) ? value.email! : 'کاربر مهمان'),
                const SizedBox(
                  height: 32,
                ),
                const Divider(
                  height: 1,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>const FavoriteScreen())),
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      children: const [
                        Icon(CupertinoIcons.heart),
                        SizedBox(
                          width: 16,
                        ),
                        Text('لیست علاقه مندی ها')
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>const OrderHistoryScreen())),
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      children: const [
                        Icon(CupertinoIcons.cart),
                        SizedBox(
                          width: 16,
                        ),
                        Text('سوابق سفارش')
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                InkWell(
                  onTap: () {
                    if (isLogin) {
                      showDialog(
                          context: context,
                          useRootNavigator: true,
                          builder: (context) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                title: const Text('خروج از حساب کاربری'),
                                content: const Text(
                                    'آیا می خواهید از حساب خود خارج شوید'),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          {Navigator.of(context).pop()},
                                      child: const Text('خیر')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        authRepository.SingOut();
                                        AuthRepository
                                            .authChangeNotifier.value = null;
                                        CartRepository
                                            .cartItemCountNotifier.value = 0;
                                      },
                                      child: const Text('بله')),
                                ],
                              ),
                            );
                          });
                    } else {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const AuthScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      children: [
                        Icon((isLogin) ? Icons.exit_to_app : Icons.login),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(isLogin
                            ? 'خروج از حساب کاربری'
                            : 'ورود به حساب کاربری')
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
              ],
            );
          }),
    );
  }
}
