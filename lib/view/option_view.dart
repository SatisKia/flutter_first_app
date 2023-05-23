import 'package:flutter/material.dart';

// ローカライゼーション
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';
import '../model.dart';
import '../model/calc_model.dart';
import '../view_model/option_view_model.dart';
import '../widget/calc_widget.dart';
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
    String stringLoadImage      = AppLocalizations.of(state.context)!.loadImage;
    String stringRemoveImage    = AppLocalizations.of(state.context)!.removeImage;
    String stringImageX         = AppLocalizations.of(state.context)!.imageX;
    String stringImageY         = AppLocalizations.of(state.context)!.imageY;

    Widget child = MyColumn( children: [
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
                title: MyTextShadow( state, stringItalic, fontSize: 15, color: 0x000000 ),
                value: state.italic,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? value) {
                  state.setItalic(value!);
                }
            ),

            MyColumnSpace( state, 10 ),

            MyTextShadow( state, stringSeparator, fontSize: 15, color: 0x000000 ),
            RadioListTile(
                title: MyTextShadow( state, stringSeparatorNone, fontSize: 15, color: 0x000000 ),
                value: CalcModel.separatorTypeNone,
                groupValue: state.separator,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (int? value) {
                  state.setSeparator(value!);
                }
            ),
            RadioListTile(
                title: MyTextShadow( state, stringSeparatorUpper, fontSize: 15, color: 0x000000 ),
                value: CalcModel.separatorTypeDash,
                groupValue: state.separator,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (int? value) {
                  state.setSeparator(value!);
                }
            ),
            RadioListTile(
                title: MyTextShadow( state, stringSeparatorLower, fontSize: 15, color: 0x000000 ),
                value: CalcModel.separatorTypeComma,
                groupValue: state.separator,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (int? value) {
                  state.setSeparator(value!);
                }
            ),

            MyColumnSpace( state, 10 ),

            Row(
                children: [
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue
                      ),
                      onPressed: state.loadImage,
                      child: MyText( state, stringLoadImage, fontSize: 15, color: 0xFFFFFF )
                  ),
                  MyRowSpace( state, 10 ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue
                      ),
                      onPressed: state.removeImage,
                      child: MyText( state, stringRemoveImage, fontSize: 15, color: 0xFFFFFF )
                  ),
                ]
            ),

            MyColumnSpace( state, 10 ),

            MyTextShadow( state, stringImageX, fontSize: 15, color: 0x000000 ),
            Slider(
              value: MyModel.app.imageX,
              min: -1.0,
              max: 1.0,
              divisions: 100,
              onChanged: state.onChangedImageX,
              onChangeEnd: state.onChangeEndImageX,
            ),
            MyTextShadow( state, stringImageY, fontSize: 15, color: 0x000000 ),
            Slider(
              value: MyModel.app.imageY,
              min: -1.0,
              max: 1.0,
              divisions: 100,
              onChanged: state.onChangedImageY,
              onChangeEnd: state.onChangeEndImageY,
            )
          ] )
      )
    ] );

    if( MyModel.app.imageFlag && MyModel.app.image != null ) {
      return Container(
          width: state.contentWidth,
          height: state.contentHeight,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: MyModel.app.image!,
                  fit: BoxFit.cover,
                  alignment: Alignment( MyModel.app.imageX, MyModel.app.imageY )
              )
          ),
          child: child
      );
    }
    return child;
  }
}
