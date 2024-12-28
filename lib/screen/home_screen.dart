import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();

  void onHeartPressed() {
    // 상태 변경 시 setState() 메서드를 호출하여 화면을 다시 그린다.
    // setState(() {
    //   // 위에 선언된 firstDay 값을 변경하여 화면을 다시 그린다.
    //   firstDay = firstDay.subtract(Duration(days: 1));
    // });

    showCupertinoDialog(
      // 쿠퍼티노 다얼로그 실행.
      context: context,
      builder: (BuildContext context) {
        // 쿠퍼티노 실행시 초기 날짜 값
        final initDate = DateFormat('yyyy-MM-dd').parse('2022-01-01');

        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              // 날짜 선택하는 다이얼로그
              mode: CupertinoDatePickerMode.date,
              // 선택한 날짜가 오늘이후로 선택되지 않도록 설정
              minimumYear: 2000,
              maximumYear: DateTime.now().year, // 현재 년도 이후는 표시가 안됨
              maximumDate: DateTime.now(),
              initialDateTime: initDate,
              onDateTimeChanged: (DateTime date) {
                setState(
                  () => {
                    firstDay = date,
                  },
                );
              },
            ),
          ),
        );
      },
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[100],
        body: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DDay(
                onHeartPressed: onHeartPressed,
                // 인자값으로 날짜를 임의로 전달할 수 있다.
                firstDay: firstDay,
                // firstDay: DateTime(2022, 1, 1),
              ),
              CoupleImage()
            ],
          ),
        ));
  }
}

class DDay extends StatefulWidget {
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;

  const DDay({
    Key? key,
    required this.onHeartPressed,
    required this.firstDay,
  }) : super(key: key);

  @override
  _DDayState createState() => _DDayState();
}

class _DDayState extends State<DDay> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final onHeartPressed = widget.onHeartPressed;
    final todayNow = DateTime.now();

    return Column(children: [
      const SizedBox(height: 16.0),
      Text(
        'U&I',
        style: textTheme.displayLarge,
      ),
      const SizedBox(height: 16.0),
      Text(
        '우리 처음 만난 날',
        style: textTheme.bodyMedium,
      ),
      Text(
          '${widget.firstDay.year}.${widget.firstDay.month}.${widget.firstDay.day}',
          style: textTheme.bodySmall),
      const SizedBox(height: 16.0),
      IconButton(
        iconSize: 60.0,
        onPressed: onHeartPressed,
        icon: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
      ),
      const SizedBox(height: 16.0),
      Text(
          'D+${DateTime(todayNow.year, todayNow.month, todayNow.day).difference(widget.firstDay).inDays + 1}',
          style: textTheme.displayMedium),
    ]);
  }
}

class CoupleImage extends StatefulWidget {
  const CoupleImage({Key? key}) : super(key: key);

  @override
  _CoupleImageState createState() => _CoupleImageState();
}

class _CoupleImageState extends State<CoupleImage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Image.asset(
          'assets/img/middle_image.png',
          height: MediaQuery.of(context).size.height / 2,
        ),
      ),
    );
  }
}
