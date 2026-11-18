enum SpaceTopic {
  general('All', null),
  nasa('NASA', 'NASA'),
  spacex('SpaceX', 'SpaceX'),
  artemis('Artemis', 'Artemis'),
  mars('Mars', 'Mars'),
  iss('ISS', 'International Space Station'),
  starship('Starship', 'Starship');

  const SpaceTopic(this.label, this.query);

  final String label;
  final String? query;
}
