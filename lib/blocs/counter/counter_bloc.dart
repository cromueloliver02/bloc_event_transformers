// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    // on<IncrementCounterEvent>(_incrementCounter);
    // on<DecrementCounterEvent>(
    //   _decrementCounter,
    //   // transformer: concurrent(), // default
    //   // transformer: droppable(),
    //   transformer: restartable(),
    // );

    on<CounterEvent>(
      _sequentialIncrementOrDecrementCounter,
      transformer: sequential(),
    );
  }

  Future<void> _incrementCounter(
    IncrementCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 4));
    emit(state.copyWith(counter: state.counter + 1));
  }

  Future<void> _decrementCounter(
    DecrementCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(counter: state.counter - 1));
  }

  Future<void> _sequentialIncrementOrDecrementCounter(
    CounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    if (event is IncrementCounterEvent) await _incrementCounter(event, emit);

    if (event is DecrementCounterEvent) await _decrementCounter(event, emit);
  }
}
