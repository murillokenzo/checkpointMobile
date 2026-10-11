import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class ResumoLotacao extends StatelessWidget {
  final int presentes;
  final int capacidade;

  const ResumoLotacao({
    super.key,
    required this.presentes,
    required this.capacidade,
  });

  bool get _vazio => presentes == 0;
  bool get _lotado => presentes >= capacidade;
  bool get _quaseCheio => presentes >= capacidade * 0.8;

  String get _mensagem {
    if (_vazio) return 'Cinema vazio';
    if (_lotado) return 'Cinema lotado';
    if (_quaseCheio) return 'Atenção: cinema quase cheio';
    return 'Pode entrar';
  }

  Color get _cor {
    if (_lotado) return AppColors.vermelho;
    if (_quaseCheio) return AppColors.laranja;
    return AppColors.verde;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card.withAlpha(230),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.dourado.withAlpha(120)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.people_alt, color: AppColors.dourado),
              const SizedBox(width: 8),
              Text(
                'Pessoas no ambiente',
                style: GoogleFonts.poppins(
                  color: AppColors.creme,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Text(
                '$presentes / $capacidade',
                style: GoogleFonts.bebasNeue(
                  color: _cor,
                  fontSize: 40,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: presentes / capacidade,
            minHeight: 8,
            borderRadius: BorderRadius.circular(8),
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation<Color>(_cor),
          ),
          const SizedBox(height: 8),
          Text(
            _mensagem,
            style: GoogleFonts.poppins(
              color: _cor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
