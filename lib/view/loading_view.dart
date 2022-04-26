import 'package:flutter/material.dart';

import '../main.dart';
import '../view_model/loading_view_model.dart';
import '../widget/common_widget.dart';

class LoadingView extends MyView {
  @override
  Widget build( MyState state ) {
    state as MyLoadingState;

    return Center(
        child: MySizedBox(
            state,
            width: 32,
            height: 32,
            child: const CircularProgressIndicator()
        )
    );
  }
}
