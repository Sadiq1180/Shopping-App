// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:projectcore/providers/dummy_provider.dart';
// import 'package:projectcore/shared/console.dart';

// import 'new_screen_ui.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class MyScreen extends ConsumerStatefulWidget {
//   static const String routeName = "new_screen";

//   const MyScreen({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => MyScreenState();
// }

// class MyScreenState extends ConsumerState<MyScreen> {
//   String? accountNumber;
//   bool? existsAccountNumber;
//   final TextEditingController controller = TextEditingController();

//   clearTextFormField() {
//     console('fafdasdfasdfasdf');
//     controller.text = '';
//     accountNumber = '';
//     // ref.read()
//     changeValue();
//   }

//   changeValue() {
//     accountNumber = Random().nextInt(100).toString();
//     setState(() {});
//   }

//   // int get count => ref.watch(dummyProvider).count!;
//   changeCount(){
//     ref.read(dummyProvider.notifier).changeCount();
//   }
//   @override
//   Widget build(BuildContext context) => NewAccountComponentView(this,ref);
// }

// // class NewAccountComponent extends ConsumerStatefulWidget {
// //   static const String routeName = "new_screen";

// //   const NewAccountComponent({super.key});

// //   @override
// //   ConsumerState<ConsumerStatefulWidget> createState() => NewAccountComponentController();
// // }

// // class NewAccountComponentController extends ConsumerState<NewAccountComponent> {
// //   String? accountNumber;
// //   bool? existsAccountNumber;
// //   final TextEditingController controller = TextEditingController();

// //   clearTextFormField() {
// //     console('fafdasdfasdfasdf');
// //     controller.text = '';
// //     accountNumber = '';
// //     changeValue();

// //   }
// //   changeValue(){
// //   accountNumber= Random().nextInt(100).toString();
// //   setState(() {
    
// //   });
// //   }

// //   @override
// //   Widget build(BuildContext context) => NewAccountComponentView(this);
// // }