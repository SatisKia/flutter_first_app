import 'package:flutter/material.dart';

import '../data/calc_data.dart';
import '../state/option_state.dart';
import '../widget/common_widget.dart';

Padding optionView( MyOptionState state ) {
  return MyPadding( state, left: 10, top: 10, right: 10, bottom: 10,
      child: MyColumn(
          children: [
            CheckboxListTile(
                title: MyOptionText( state, '計算結果をイタリックに', 15 ),
                value: state.italic,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? value) {
                  state.setItalic(value!);
                }
            ),

            MyColumnSpace( state, 10 ),

            MyOptionText( state, '桁区切り:', 15 ),
            RadioListTile(
                title: MyOptionText( state, 'なし', 15 ),
                value: CalcData.separatorTypeNone,
                groupValue: state.separator,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (int? value) {
                  state.setSeparator(value!);
                }
            ),
            RadioListTile(
                title: MyOptionText( state, '上部', 15 ),
                value: CalcData.separatorTypeDash,
                groupValue: state.separator,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (int? value) {
                  state.setSeparator(value!);
                }
            ),
            RadioListTile(
                title: MyOptionText( state, '下部', 15 ),
                value: CalcData.separatorTypeComma,
                groupValue: state.separator,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (int? value) {
                  state.setSeparator(value!);
                }
            ),
          ] )
  );
}
