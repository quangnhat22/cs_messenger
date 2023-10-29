enum AppRequestType {
  friendReceived(type: 'friend', direction: 'in'),
  friendSent(type: 'friend', direction: 'out'),
  groupReceived(type: 'group', direction: 'in'),
  groupSent(type: 'group', direction: 'out');

  const AppRequestType({required this.type, required this.direction});

  final String type;
  final String direction;
}
