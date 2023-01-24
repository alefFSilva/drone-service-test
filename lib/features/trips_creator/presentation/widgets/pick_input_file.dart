import 'package:drone_service/features/trips_creator/presentation/cubits/trips_creator_cubit.dart';
import 'package:drone_service/features/trips_creator/presentation/cubits/trips_creator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickInputFile extends StatelessWidget {
  const PickInputFile({
    required this.tripsCreatorCubit,
    required this.onPickFile,
    required this.onPickDirectory,
    this.onCreateSomeTrip,
    super.key,
  });

  final TripsCreatorCubit tripsCreatorCubit;
  final VoidCallback onPickFile;
  final VoidCallback onPickDirectory;
  final VoidCallback? onCreateSomeTrip;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripsCreatorCubit, TripsCreatorState>(
      bloc: tripsCreatorCubit,
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        }
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: onPickFile,
                  child: const Text('Select the input file'),
                ),
                Text(
                  state.fileToLoad,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: onPickDirectory,
                  child: const Text(
                    'Select a directory to save the output',
                  ),
                ),
                Text(
                  state.pathToSave,
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: onCreateSomeTrip,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text(
                    'Create some trips!!',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
