

# Drone Delivery Service

A project developed for the Velozient mobile developer position.
The goal of this application is to support a drone delivery  by managing each drone capacity and location to delivery order weight.
The application shall receive an input file with the drone squad and location details, process it and create an output file with the drone squad trips.

<img width="863" alt="image" src="https://user-images.githubusercontent.com/23003445/214309724-23a0c956-8dc0-4b48-b15c-e6f0f3099fee.png">
<img width="863" alt="image" src="https://user-images.githubusercontent.com/23003445/214309856-c0fc3033-2640-4474-b05d-1c50798b1214.png">
<img width="863" alt="image" src="https://user-images.githubusercontent.com/23003445/214309907-3852aa47-4400-45c7-9321-1cb20a032839.png">
<img width="863" alt="image" src="https://user-images.githubusercontent.com/23003445/214310107-c3bc443d-a3ce-4668-b83f-55c2793e7f3b.png">



## Algorithm
I used the recursive method to re-use the create trips function.

## Approach
My steps to prepare my self were:

- Read, analyze and take some notes about the challenge summary 
- Plan the data structure based on the summary
- Take some note about the statements like: 
	- Drones should make the fewer number of trips
	- Software shall accept a file with the name of each drone, maximum weight and deliverie's location.
- I also draw a [structure strategy at Miro](https://miro.com/app/board/uXjVPvNM68o=/?share_link_id=947866242231) 

About the business solution my approch steps were:

I thought it was a good start to get the drone with more capacity, the location with   more weight to delivery and try to match them.
After the most heavy location been alocate on a trip, I'll analyze if the current drone still having capacity remaining.
If so, I start to look for a location that can fit the remaining space.
And after the current drone capacity is over, I select the next one sorted by capacity and apply the algorithm again using the recursive method.


## Technical Dependencies and Libraries

I developed this application using the [VS Code as IDE](https://code.visualstudio.com/download), [Flutter 3.3.10, Dart 2.18](https://docs.flutter.dev/development/tools/sdk/releases) on MacOS Ventura 13.1.
To help with some UI tasks, I also used the packages [file_picker](https://pub.dev/packages/file_picker)  and the [flutter_bloc](https://pub.dev/packages/flutter_bloc).


## How to run

- Clone this repository
- Enter to project location and run `flutter run --{web or macos or windows}`


## How to use

- Select the input file
- Select the directory to save the output
- Click on "Create some trips"


## Input and Outputs samples


[Input.txt](https://github.com/alefFSilva/drone-service-test/files/10490505/Input.txt)
[Output.txt](https://github.com/alefFSilva/drone-service-test/files/10490506/Output.txt)



