import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LeftPanelView extends StatelessWidget {
  const LeftPanelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      width: 80,
      color: Colors.red,
      child: Column(
        children: [
          SvgPicture.asset('icons/filter_icon.svg'),
          const SizedBox(
            height: 30,
          ),
          SvgPicture.asset('icons/options_icon.svg'),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(),
                  onPressed: () {},
                  child: const Icon(Icons.add),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
