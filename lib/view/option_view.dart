import 'package:flutter/material.dart';

import '../data/calc_data.dart';
import '../main.dart';
import '../state/option_state.dart';
import '../widget/common_widget.dart';

class OptionView extends MyView {
  @override
  Widget build( MyState state ) {
    state as MyOptionState;

    return MyColumn( children: [
      MyElevatedButton( state,
        width: 320,
        height: 40,
        color: Colors.blue.value,
        onPressed: () { state.onButtonBack(); },
        child: MyText( state, "戻る", fontSize: 16, color: 0xFFFFFF ),
      ),

      MyPadding( state, left: 10, top: 10, right: 10, bottom: 10,
          child: MyColumn( children: [
            CheckboxListTile(
                title: MyText( state, '計算結果をイタリックに', fontSize: 15, color: 0x000000 ),
                value: state.italic,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? value) {
                  state.setItalic(value!);
                }
            ),

            MyColumnSpace( state, 10 ),

            MyText( state, '桁区切り:', fontSize: 15, color: 0x000000 ),
            RadioListTile(
                title: MyText( state, 'なし', fontSize: 15, color: 0x000000 ),
                value: CalcData.separatorTypeNone,
                groupValue: state.separator,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (int? value) {
                  state.setSeparator(value!);
                }
            ),
            RadioListTile(
                title: MyText( state, '上部', fontSize: 15, color: 0x000000 ),
                value: CalcData.separatorTypeDash,
                groupValue: state.separator,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (int? value) {
                  state.setSeparator(value!);
                }
            ),
            RadioListTile(
                title: MyText( state, '下部', fontSize: 15, color: 0x000000 ),
                value: CalcData.separatorTypeComma,
                groupValue: state.separator,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (int? value) {
                  state.setSeparator(value!);
                }
            ),
          ] )
      ) ]
    );
  }
}
