import 'package:bot/logic/message_bloc/bloc/message_bloc.dart';
import 'package:bot/presentation/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: TextField(
                  controller: textEditingController,
                  cursorColor: Colors.white,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    hintStyle: GoogleFonts.roboto(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Gap(10),
            BlocConsumer<MessageBloc, MessageState>(
              listener: (context, state) {
                if (state is MessagePostedState) {
                  textEditingController.clear();
                  FocusScope.of(context).unfocus();
                }
              },
              builder: (context, state) {
                if (state is MessagePostedState && state.isLoading) {
                  return CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1,
                  );
                }
                if (state is MessagePostedState) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (textEditingController.text.trim() == '') {
                          snackBar(
                              context: context, message: "Enter Something");
                          return;
                        }
                        BlocProvider.of<MessageBloc>(context).add(
                          PostMessageEvent(
                            message: textEditingController.text,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_upward,
                        ),
                      ),
                    ),
                  );
                } else {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (textEditingController.text.trim() == '') {
                          snackBar(
                              context: context, message: "Enter something");
                          return;
                        }
                        BlocProvider.of<MessageBloc>(context).add(
                          PostMessageEvent(
                            message: textEditingController.text,
                          ),
                        );
                        textEditingController.clear();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_upward,
                        ),
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
