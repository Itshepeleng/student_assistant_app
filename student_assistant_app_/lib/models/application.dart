class Application {
  final String id;      //student id
  final String position;      //the position they are applying for
  final String status;        //application status
  final DateTime dateSubmitted;     

  Application({
    required this.id,
    required this.position,
    required this.status,
    required this.dateSubmitted,
  });
}

