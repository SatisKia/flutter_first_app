import 'package:flutter/material.dart';

import '../state/loading_state.dart';
import '../widget/common_widget.dart';

Column loadingView( MyLoadingState state ) {
  return MyColumn(
    hAlign: MyColumn.hAlignCenter,
    vAlign: MyColumn.vAlignCenter,
    children: [
      MyContainer( state, width: 32, height: 32,
          child: const CircularProgressIndicator()
      )
    ],
  );
}
