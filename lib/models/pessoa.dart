class Pessoa {
  final String nome;
  final String identificacao;
  final DateTime dataEntrada;
  DateTime? dataSaida; 

  Pessoa({
    required this.nome,
    required this.identificacao,
    required this.dataEntrada,
    this.dataSaida,
  });

   bool get noAmbiente => dataSaida == null;

   String get situacao => noAmbiente ? 'No ambiente' : 'Saiu';

    void registrarSaida() {
    dataSaida = DateTime.now();
  }
}
