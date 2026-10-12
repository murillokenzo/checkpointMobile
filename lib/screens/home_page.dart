import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/pessoa.dart';
import '../theme/app_colors.dart';
import '../widgets/pessoa_item.dart';
import '../widgets/resumo_lotacao.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int capacidadeMaxima = 3;

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  final List<Pessoa> _pessoas = [];

  int get _presentes => _pessoas.where((p) => p.noAmbiente).length;

  bool get _lotado => _presentes >= capacidadeMaxima;

  @override
  void dispose() {
    _nomeController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _mostrarMensagem(String texto, {bool erro = false}) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: erro ? AppColors.vermelho : AppColors.verdeEscuro,
        content: Text(
          texto,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmar({required String titulo, required String mensagem}) async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text(
          titulo,
          style: GoogleFonts.bebasNeue(
            color: AppColors.dourado,
            fontSize: 26,
            letterSpacing: 1,
          ),
        ),
        content: Text(
          mensagem,
          style: GoogleFonts.poppins(color: AppColors.creme),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'CANCELAR',
              style: GoogleFonts.poppins(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'CONFIRMAR',
              style: GoogleFonts.poppins(
                color: AppColors.dourado,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
    return resultado ?? false; // se fechar o diálogo sem escolher = cancelar
  }

  void _cadastrarPessoa() {
    final nome = _nomeController.text.trim();
    final id = _idController.text.trim();

    if (nome.isEmpty || id.isEmpty) {
      _mostrarMensagem('Preencha o nome e a identificação!', erro: true);
      return;
    }

    if (_lotado) {
      _mostrarMensagem(
        'Não é possível realizar a entrada. Ambiente lotado!',
        erro: true,
      );
      return;
    }

    final duplicado = _pessoas.any(
      (p) => p.noAmbiente && p.identificacao.toLowerCase() == id.toLowerCase(),
    );
    if (duplicado) {
      _mostrarMensagem(
        'Já existe uma pessoa no ambiente com essa identificação!',
        erro: true,
      );
      return;
    }

    setState(() {
      _pessoas.insert(
        0, 
        Pessoa(nome: nome, identificacao: id, dataEntrada: DateTime.now()),
      );
    });

    _nomeController.clear();
    _idController.clear();
    FocusScope.of(context).unfocus();
    _mostrarMensagem('Pessoa cadastrada com sucesso!');
  }

  Future<void> _registrarSaida(Pessoa pessoa) async {
    if (!pessoa.noAmbiente) {
      _mostrarMensagem('${pessoa.nome} já registrou a saída!', erro: true);
      return;
    }

    final confirmou = await _confirmar(
      titulo: 'Registrar saída?',
      mensagem: 'Deseja realmente registrar a saída de ${pessoa.nome}?',
    );
    if (!confirmou || !mounted) return;

    setState(() {
      pessoa.registrarSaida();
    });
    _mostrarMensagem('Saída registrada com sucesso!');
  }

  Future<void> _excluirPessoa(Pessoa pessoa) async {
    final confirmou = await _confirmar(
      titulo: 'Excluir registro?',
      mensagem: 'Deseja realmente excluir o registro de ${pessoa.nome}?',
    );
    if (!confirmou || !mounted) return;

    setState(() {
      _pessoas.remove(pessoa);
    });
    _mostrarMensagem('Registro excluído com sucesso!');
  }

  Widget _campo({
    required TextEditingController controller,
    required String label,
    required IconData icone,
    TextInputAction acao = TextInputAction.next,
  }) {
    return TextField(
      controller: controller,
      textInputAction: acao,
      style: GoogleFonts.poppins(color: AppColors.creme),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.white60),
        prefixIcon: Icon(icone, color: AppColors.dourado),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dourado),
        ),
      ),
    );
  }

  Widget _formulario() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card.withAlpha(230),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _campo(
                  controller: _nomeController,
                  label: 'Nome',
                  icone: Icons.person,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: _campo(
                  controller: _idController,
                  label: 'ID / Matrícula',
                  icone: Icons.badge,
                  acao: TextInputAction.done,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: _cadastrarPessoa,
              icon: const Icon(Icons.confirmation_number),
              label: Text(
                'REGISTRAR ENTRADA',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.dourado,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fundo,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cinema_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withAlpha(170),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.movie_filter,
                        color: AppColors.dourado,
                        size: 30,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'CONTROLE DE LOTAÇÃO',
                        style: GoogleFonts.bebasNeue(
                          color: AppColors.creme,
                          fontSize: 30,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'CINEMA  •  Gerenciamento de acessos',
                    style: GoogleFonts.poppins(
                      color: AppColors.dourado,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ResumoLotacao(
                    presentes: _presentes,
                    capacidade: capacidadeMaxima,
                  ),
                  const SizedBox(height: 12),
                  _formulario(),
                  const SizedBox(height: 14),
                  Text(
                    'Pessoas cadastradas (${_pessoas.length})',
                    style: GoogleFonts.poppins(
                      color: AppColors.creme,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _pessoas.isEmpty
                        ? Center(
                            child: Text(
                              'Nenhuma pessoa cadastrada ainda.',
                              style: GoogleFonts.poppins(color: Colors.white54),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _pessoas.length,
                            itemBuilder: (context, index) {
                              final pessoa = _pessoas[index];
                              return PessoaItem(
                                pessoa: pessoa,
                                onSaida: () => _registrarSaida(pessoa),
                                onExcluir: () => _excluirPessoa(pessoa),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
