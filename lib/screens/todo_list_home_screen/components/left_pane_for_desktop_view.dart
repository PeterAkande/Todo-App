import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class LeftPanelView extends StatelessWidget {
  const LeftPanelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 30,
      ),
      width: 79,
      decoration: BoxDecoration(
        color: appPrimaryColorLight,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        boxShadow: const [
          BoxShadow(
              offset: Offset(-9, 0),
              color: Colors.black,
              blurRadius: 10,
              spreadRadius: 10)
        ],
      ),
      child: Column(
        children: [
          IconButton(
            iconSize: 20,
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/filter_icon.svg'),
          ),
          const SizedBox(
            height: 10,
          ),
          IconButton(
            iconSize: 25,
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: SizedBox(
                    height: 65,
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: const MaterialStatePropertyAll(0),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor: const MaterialStatePropertyAll(
                              Color(0xFF363636))),
                      onPressed: () {},
                      child: const Icon(Icons.add),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
