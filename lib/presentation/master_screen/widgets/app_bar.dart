import 'package:bot/logic/message_bloc/bloc/message_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

AppBar appBar({required context}) {
  return AppBar(
    title: Image.asset(
      'assets/images/heycoachlogo.png',
      width: 120,
    ),
    centerTitle: false,
    actions: [
      InkWell(
        onTap: () {
          BlocProvider.of<MessageBloc>(context).add(MessagesResetEvent());
          Toast.show(
            "New instance",
            gravity: Toast.bottom,
            duration: Toast.lengthShort,
            backgroundColor: Colors.black,
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 105, 102, 102),
                Color.fromARGB(255, 80, 77, 77),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 10,
            ),
            child: Icon(
              Icons.add,
              size: 18,
            ),
          ),
        ),
      )
    ],
    surfaceTintColor: Colors.grey[900],
    backgroundColor: Colors.grey[900],
    foregroundColor: Colors.white,
  );
}
