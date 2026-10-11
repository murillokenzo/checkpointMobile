import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/pessoa.dart';
import '../theme/app_colors.dart';

class PessoaItem extends StatelessWidget {
  final Pessoa pessoa;
  final VoidCallback onSaida;
  final VoidCallback onExcluir;

  const PessoaItem({
    super.key,
    required this.pessoa,
    required this.onSaida,
    required this.onExcluir,
  });

  static final DateFormat _formato = DateFormat("dd/MM/yyyy 'às' HH:mm");

  TextStyle get _estiloInfo =>
      GoogleFonts.poppins(color: Colors.white70, fontSize: 13);

  @override
  Widget build(BuildContext context) {
    final Color corSituacao =
        pessoa.noAmbiente ? AppColors.verde : AppColors.laranja;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Slidable(
          key: ValueKey(pessoa),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.55,
            children: [
              SlidableAction(
                onPressed: (_) => onSaida(),
                backgroundColor: AppColors.laranja,
                foregroundColor: Colors.black,
                icon: Icons.logout,
                label: 'SAÍDA',
              ),
              SlidableAction(
                onPressed: (_) => onExcluir(),
                backgroundColor: AppColors.vermelho,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'EXCLUIR',
              ),
            ],
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: AppColors.card.withAlpha(235),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: corSituacao.withAlpha(50),
                  child: Icon(
                    pessoa.noAmbiente
                        ? Icons.event_seat
                        : Icons.directions_walk,
                    color: corSituacao,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pessoa.nome,
                        style: GoogleFonts.poppins(
                          color: AppColors.creme,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text('ID: ${pessoa.identificacao}', style: _estiloInfo),
                      Text(
                        'Entrada: ${_formato.format(pessoa.dataEntrada)}',
                        style: _estiloInfo,
                      ),
                      if (pessoa.dataSaida != null)
                        Text(
                          'Saída: ${_formato.format(pessoa.dataSaida!)}',
                          style: _estiloInfo,
                        ),
                      const SizedBox(height: 4),
                      Text(
                        'Situação: ${pessoa.situacao}',
                        style: GoogleFonts.poppins(
                          color: corSituacao,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_left, color: Colors.white38),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
