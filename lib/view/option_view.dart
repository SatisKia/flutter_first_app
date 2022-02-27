import 'package:flutter/material.dart';

// ローカライゼーション
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../data/calc_data.dart';
import '../main.dart';
import '../state/option_state.dart';
import '../widget/common_widget.dart';

class OptionView extends MyView {
  @override
  Widget build( MyState state ) {
    state as MyOptionState;

    // ローカライゼーション
    String stringBack           = AppLocalizations.of(state.context)!.back;
    String stringItalic         = AppLocalizations.of(state.context)!.italic;
    String stringSeparator      = AppLocalizations.of(state.context)!.separator;
    String stringSeparatorNone  = AppLocalizations.of(state.context)!.separatorNone;
    String stringSeparatorUpper = AppLocalizations.of(state.context)!.separatorUpper;
    String stringSeparatorLower = AppLocalizations.of(state.context)!.separatorLower;

    return MyColumn( children: [
      MyElevatedButton( state,
        width: 320,
        height: 40,
        color: Colors.blue.value,
        onPressed: () { state.onButtonBack(); },
        child: MyText( state, stringBack, fontSize: 16, color: 0xFFFFFF ),
      ),

      MyPadding( state, left: 10, top: 10, right: 10, bottom: 10,
          child: MyColumn( children: [
            CheckboxListTile(
                title: MyText( state, stringItalic, fontSize: 15, color: 0x000000 ),
                value: state.italic,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? value) {
                  state.setItalic(value!);
                }
            ),

            MyColumnSpace( state, 10 ),

            MyText( state, stringSeparator, fontSize: 15, color: 0x000000 ),
            RadioListTile(
                title: MyText( state, stringSeparatorNone, fontSize: 15, color: 0x000000 ),
                value: CalcData.separatorTypeNone,
                groupValue: state.separator,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (int? value) {
                  state.setSeparator(value!);
                }
            ),
            RadioListTile(
                title: MyText( state, stringSeparatorUpper, fontSize: 15, color: 0x000000 ),
                value: CalcData.separatorTypeDash,
                groupValue: state.separator,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (int? value) {
                  state.setSeparator(value!);
                }
            ),
            RadioListTile(
                title: MyText( state, stringSeparatorLower, fontSize: 15, color: 0x000000 ),
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
