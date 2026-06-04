import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<InitializeAppEvent>(_onInitializeApp);
  }

  Future<void> _onInitializeApp(InitializeAppEvent event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    
    // Showcase async workflow management (warm up background caches, analytics pipelines, or auth handshakes)
    await Future.delayed(const Duration(milliseconds: 2500)); 
    
    emit(SplashCompleted());
  }
}