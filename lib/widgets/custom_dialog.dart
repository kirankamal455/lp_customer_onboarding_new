import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.onTapYesBtn,
    required this.onTapNoBtn,
    this.tittle,
    required this.subTittle,
    required this.isTittleVisible,
  });

  final void Function() onTapYesBtn;
  final void Function() onTapNoBtn;
  final String? tittle;
  final String subTittle;
  final bool isTittleVisible;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: [
          [
            if (isTittleVisible)
              [
                Text(
                  tittle ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                10.heightBox,
              ].vStack(),
            Text(
              subTittle,
              style: const TextStyle(
                fontSize: 13,
              ),
            ).p(8),
          ].vStack().p(18),
          const Spacer(),
          [
            Consumer(
              builder: (context, ref, child) {
                return Container(
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: "No".text.make().centered(),
                )
                    .box
                    .withDecoration(
                      BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                      ),
                    )
                    .make()
                    .onTap(
                      () => onTapNoBtn(),
                    )
                    .expand();
              },
            ),
            Container(
              height: 46,
              decoration: BoxDecoration(
                color: context.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: "Yes".text.color(Colors.white).make().centered(),
            ).onTap(() => onTapYesBtn()).expand()
          ].hStack(alignment: MainAxisAlignment.spaceBetween),

          // )
        ].vStack().h(160),
      ).pOnly(left: 30, right: 30),
    );
  }
}
