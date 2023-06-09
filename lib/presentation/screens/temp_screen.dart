import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soon_sak/app/di/locator/locator.dart';
import 'package:soon_sak/domain/model/content/content.dart';
import 'package:soon_sak/presentation/base/base_screen.dart';
import 'package:soon_sak/presentation/base/base_view.dart';
import 'package:soon_sak/presentation/base/base_view_model.dart';
import 'package:soon_sak/presentation/screens/contentDetail/content_detail_view_model.dart';

class TempViewModel extends BaseViewModel {
  int count = 0;
  int extraCount = 0;

  void countUp() {
    count++;
    notifyListeners();
  }

  void extraCountUp() {
    extraCount++;
    notifyListeners();
  }
}

class TempScreen extends BaseScreen<TempViewModel> {
  const TempScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    print('RENDERED EFFECT');
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context
              .select<TempViewModel, int>((value) => value.count)
              .toString()),
          Row(
            children: [
              ElevatedButton(
                  onPressed: vm(context).countUp, child: Text('Count up Btn')),
              ElevatedButton(
                  onPressed: vm(context).extraCountUp,
                  child: Text('ExtraCount up')),
            ],
          )
        ],
      ),
    );
  }

  @override
  TempViewModel createViewModel(BuildContext context) =>
      locator.registerSingleton(TempViewModel());
}

class TestView extends BaseView<TempViewModel> {
  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        context.select<TempViewModel, int>((value) => value.count).toString());
  }
}
