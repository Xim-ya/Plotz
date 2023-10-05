import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class MyProfileInfoView extends BaseView<MyPageViewModel> {
  const MyProfileInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: vm(context).userInfoSub.stream,
      builder: (context, snapshot) {
        return Center(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: vm(context).routeToProfileSetting,
                child: RoundProfileImg(
                  size: 90,
                  imgUrl: snapshot.data?.photoUrl,
                ),
              ),
              AppSpace.size14,
              Transform.translate(
                offset: const Offset(10, 0),
                child: TextButton(
                  onPressed: vm(context).routeToProfileSetting,
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.only(
                      right: 24,
                      left: 4,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Text(
                        snapshot.data?.displayName ?? '-',
                        style: AppTextStyle.headline1.copyWith(
                          color: AppColor.mixedWhite,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: -22,
                        child: SvgPicture.asset(
                          'assets/icons/edit.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
