import 'package:drone_service/features/trips_creator/presentation/cubits/trips_creator_state.dart';
import 'package:drone_service/features/trips_creator/presentation/widgets/pick_input_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/trips_creator_cubit.dart';

class TripCreator extends StatefulWidget {
  const TripCreator({super.key});

  @override
  State<TripCreator> createState() => _TripCreatorState();
}

class _TripCreatorState extends State<TripCreator> {
  late final TripsCreatorCubit _creatorCubit;

  @override
  void initState() {
    super.initState();
    _creatorCubit = TripsCreatorCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drone Service Trips creator'),
      ),
      body: Center(
        child: BlocBuilder<TripsCreatorCubit, TripsCreatorState>(
          bloc: _creatorCubit,
          builder: (context, state) {
            return PickInputFile(
              tripsCreatorCubit: _creatorCubit,
              onPickFile: () => _creatorCubit.pickFile(),
              onPickDirectory: () => _creatorCubit.pickDirectory(),
              onCreateSomeTrip:
                  (state.fileToLoad.isNotEmpty && state.pathToSave.isNotEmpty)
                      ? () => _creatorCubit.createTrips()
                      : null,
            );
          },
        ),
      ),
    );
  }
}
