class ReportStatus {
  final int dilaporkan;
  final int diproses;
  final int selesai;

  ReportStatus({
    required this.dilaporkan,
    required this.diproses,
    required this.selesai,
  });

  factory ReportStatus.fromJson(Map<String, dynamic> json) {
    return ReportStatus(
      dilaporkan: json['dilaporkan'],
      diproses: json['diproses'],
      selesai: json['selesai'],
    );
  }
}
