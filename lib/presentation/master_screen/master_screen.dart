import 'dart:async';

import 'package:bot/data/models/message_model.dart';
import 'package:bot/logic/message_bloc/bloc/message_bloc.dart';
import 'package:bot/presentation/master_screen/widgets/app_bar.dart';
import 'package:bot/presentation/master_screen/widgets/text_field.dart';
import 'package:bot/presentation/utils/sample_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  ScrollController _scrollController = ScrollController();
  final toastContext = ToastContext();

  @override
  void initState() {
    super.initState();

    toastContext.init(context);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      final double maxScroll = _scrollController.position.maxScrollExtent;
      _scrollController.animateTo(
        maxScroll,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar(context: context),
      body: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            color: const Color.fromARGB(255, 26, 26, 26),
            height: MediaQuery.of(context).size.height,
            width: 400,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: BlocConsumer<MessageBloc, MessageState>(
                  listener: (context, state) {
                    if (state is MessagePostedState) {
                      Future.delayed(Duration(milliseconds: 500), () {
                        _scrollToBottom();
                      });
                      ;
                    }
                  },
                  builder: (context, state) {
                    if (state is MessagePostedState) {
                      List messages = state.messageModel;
                      return Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.73,
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                MessageModel message = messages[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 30,
                                        left: 20,
                                      ),
                                      child: SizedBox(
                                        width: screenWidth,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/profile.png',
                                                  width: 20,
                                                ),
                                                Gap(10),
                                                Text(
                                                  "You",
                                                  style: GoogleFonts.lato(
                                                    color: Colors.grey[200],
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Gap(5),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 32.0,
                                                right: 8,
                                              ),
                                              child: Text(
                                                message.message,
                                                style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 30,
                                        left: 20,
                                      ),
                                      child: SizedBox(
                                        width: screenWidth,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/botImage.webp',
                                                  width: 20,
                                                ),
                                                Gap(10),
                                                Text(
                                                  "Bot",
                                                  style: GoogleFonts.lato(
                                                    color: Colors.grey[200],
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Gap(5),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 32.0,
                                                right: 8,
                                              ),
                                              child: Text(
                                                message.reply,
                                                style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          FloatingActionButton(
                            enableFeedback: true,
                            mini: true,
                            backgroundColor: Colors.transparent,
                            splashColor: Colors.grey,
                            onPressed: () {
                              _scrollToBottom();
                            },
                            child: FaIcon(
                              FontAwesomeIcons.angleDown,
                              size: 20,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      );
                    } else if (state is MessagePostError) {
                      return Text(state.error);
                    } else {
                      return SizedBox(
                        width: screenWidth,
                        height: screenHeight * 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              child: Image.asset(
                                'assets/images/compresslogo.png',
                                width: 40,
                              ),
                            ),
                            Gap(20),
                            Text(
                              "How can i help you today ?",
                              style: GoogleFonts.lato(
                                color: Colors.grey[300],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(20),
                            SizedBox(
                              height: screenHeight * 0.5,
                              child: ListView.builder(
                                itemCount: suggestions.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      BlocProvider.of<MessageBloc>(context).add(
                                        PostMessageEvent(
                                          message: suggestions[index],
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 10,
                                      ),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(40),
                                          ),
                                          border: Border.all(
                                            width: 0.3,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 40,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              suggestions[index],
                                              style: GoogleFonts.lato(
                                                color: Colors.grey[200],
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          CustomTextField()
        ],
      ),
    );
  }
}
