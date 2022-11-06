import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/counter/counter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Event Transformer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<CounterBloc>(
        create: (ctx) => CounterBloc(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BLOC EVENT TRANSFORMER')),
      body: Center(
        child: BlocSelector<CounterBloc, CounterState, int>(
          selector: (state) => state.counter,
          builder: (ctx, counter) => Text(
            '$counter',
            style: const TextStyle(fontSize: 52),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () =>
                context.read<CounterBloc>().add(IncrementCounterEvent()),
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () =>
                context.read<CounterBloc>().add(DecrementCounterEvent()),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
