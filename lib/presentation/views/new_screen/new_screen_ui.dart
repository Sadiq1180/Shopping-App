// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:projectcore/presentation/base_widgets/stateful_view.dart';
// import 'package:projectcore/providers/dummy_provider.dart';
// import 'package:projectcore/shared/console.dart';

// import 'new_screen_logic.dart';
// class NewAccountComponentView
//     extends StatefulView<MyScreen, MyScreenState> {

//   NewAccountComponentView(MyScreenState state, WidgetRef ref): super(state);

//   @override
//   Widget build(BuildContext context) {
//     console('sfasfdasfd');
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(onPressed: (){
//             // state.clearTextFormField();
//             state.changeCount();
//           }, child: Text('raeraeraser')),
//           Center(child: Consumer(
//             builder: (context,ref,c) {
//               return Text('raeraeraser ${state.accountNumber} ${ref.watch(dummyProvider).count}');
//             }
//           ),),
//         ],
//       ),
//     );
//     // AlertDialog(
//     //   title: Text('Enter a Unique Account Number'),
//     //   titlePadding: EdgeInsets.all(20.0),
//     //   content: TextFormField(
//     //     controller: state.controller,
//     //     onSaved: (value) => state.clearTextFormField(),
//     //   ),
//     // );
//   }
// }