import 'package:flutter/cupertino.dart'; // ios와 비슷한 스타일들을 불러올때
import 'package:flutter/material.dart'; // 안드로이드,구글 관련 디자인을 할 때

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// 최상위 위젯에서 상태를 관리하는게 훨씬더 코드에 유리하다. (데이터사방팔방X)
// 탑파트의 Stateful위젯을 홈스크린으로 옮기기!
class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ); // 변경된날짜

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        // Safe Area로 영역 설정
        bottom: false, // 아래엔 safeArea 적용 X
        child: SizedBox(
          width: MediaQuery.of(context).size.width, // 중앙 배치
          child: Column(
            children: [
              _TopPart(
                selectedDate: selectedDate,
                onPressed: onHeartPressed,
              ),
              const _BottomPart(),
            ],
          ),
        ),
      ),
    );
  }

  onHeartPressed() {
    final DateTime now = DateTime.now();

    // dialog
    showCupertinoDialog(
      // 하트를 눌렀을때 dialog
      context: context,
      barrierDismissible: true, // 밖을 누르면 닫힘
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter, // 어디에다 정렬할지 지정
          child: Container(
            color: Colors.white,
            height: 300.0, // 특정위젯을 어디에 정렬하는지 알수없으면 최대사이즈를 먹는다.
            child: CupertinoDatePicker(
              // 날짜 선택 위젯 CupertinoDatePickerMode
              // Date Picker의 맨 처음으로 선택되어있는 날짜가 실행순간 DateTime.now 로저장됨
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate, // 날짜 초기화
              maximumDate: DateTime(
                // 설정가능한 날짜는 오늘까지
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ),
              onDateTimeChanged: (DateTime date) {
                //print(date);

                setState(() {
                  //변수를 변경할때 (빌드를 다시 실행할때)
                  selectedDate = date;
                });
              },
            ),
          ),
        );
      },
    );
  }
}

class _TopPart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;
  const _TopPart(
      {required this.selectedDate, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 가장 가까운 테마를 가져온다.
    final textTheme = theme.textTheme;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // spaceBetween
        children: [
          Text(
            'U & I',
            style: textTheme.headlineLarge,
          ),
          Column(
            children: [
              // 두 텍스트 간격 좁게하기위해 Column으로 감싼다.
              Text('우리 처음 만난 날', style: textTheme.bodyLarge),
              Text(
                  '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
                  style: textTheme.bodyMedium),
            ],
          ),
          IconButton(
            iconSize: 60.0,
            onPressed: onPressed, // #
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          Text(
            'D+${DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                ).difference(selectedDate).inDays + 1}', // 날짜로 차이를 표현
            style: textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // 현재 차지할 수 있는 크기의 최대한만 차지! (넘치지않게)
      child: Image.asset(
        'asset/img/middle_image.png',
      ),
    );
  }
}



// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   DateTime selectedDate = DateTime(
//     DateTime
//         .now()
//         .year,
//     DateTime
//         .now()
//         .month,
//     DateTime
//         .now()
//         .day,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink[100],
//       body: SafeArea(
//         bottom: false,
//         child: Container(
//           width: MediaQuery
//               .of(context)
//               .size
//               .width,
//           child: Column(
//             children: [
//               _TopPart(
//                 selectedDate: selectedDate,
//                 onPressed: onHeartPressed,
//               ),
//               _BottomPart(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void onHeartPressed() {
//     final DateTime now = DateTime.now();

//     // dialog
//     showCupertinoDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             color: Colors.white,
//             height: 300.0,
//             child: CupertinoDatePicker(
//               mode: CupertinoDatePickerMode.date,
//               initialDateTime: selectedDate,
//               maximumDate: DateTime(
//                 now.year,
//                 now.month,
//                 now.day,
//               ),
//               onDateTimeChanged: (DateTime date) {
//                 setState(() {
//                   selectedDate = date;
//                 });
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _TopPart extends StatelessWidget {
//   final DateTime selectedDate;
//   final VoidCallback onPressed;

//   _TopPart({
//     required this.selectedDate,
//     required this.onPressed,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final textTheme = theme.textTheme;
//     final now = DateTime.now();

//     return Expanded(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text(
//             'U&I',
//             style: textTheme.headline1,
//           ),
//           Column(
//             children: [
//               Text(
//                 '우리 처음 만난날',
//                 style: textTheme.bodyText1,
//               ),
//               Text(
//                 '${selectedDate.year}.${selectedDate.month}.${selectedDate
//                     .day}',
//                 style: textTheme.bodyText2,
//               ),
//             ],
//           ),
//           IconButton(
//             iconSize: 60.0,
//             onPressed: onPressed,
//             icon: Icon(
//               Icons.favorite,
//               color: Colors.red,
//             ),
//           ),
//           Text(
//             'D+${DateTime(
//               now.year,
//               now.month,
//               now.day,
//             )
//                 .difference(selectedDate)
//                 .inDays + 1}',
//             style: textTheme.headline2,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _BottomPart extends StatelessWidget {
//   const _BottomPart({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Image.asset(
//         'asset/img/middle_image.png',
//       ),
//     );
//   }
// }
