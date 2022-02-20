import 'package:flutter/material.dart';

import '../main.dart';
import '../state/loading_state.dart';

class LoadingView extends MyView {
  @override
  Widget build( MyState state ) {
    state as MyLoadingState;

    return Center(
        child: SizedBox(
            width: state.size( 32 ),
            height: state.size( 32 ),
            child: const CircularProgressIndicator()
        )
    );
  }
}
