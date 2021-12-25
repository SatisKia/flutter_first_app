import 'package:flutter/material.dart';

import '../state/loading_state.dart';

Widget loadingView( MyLoadingState state ) {
  return Center(
      child: SizedBox(
          width: state.size( 32 ),
          height: state.size( 32 ),
          child: const CircularProgressIndicator()
      )
  );
}
