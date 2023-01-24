import '../domain/entities/drone.dart';
import '../domain/entities/location.dart';

class InputFileDTO {
  InputFileDTO({
    required this.dronesList,
    required this.locationsList,
  });

  List<Drone> dronesList;
  List<Location> locationsList;
}
