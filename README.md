# Controle de Lotação 2.0 — Gerenciamento de Acessos

## Descrição
Aplicativo Flutter que controla a entrada e a saída de pessoas em um cinema.
É possível cadastrar pessoas, registrar a saída, excluir registros e acompanhar
em tempo real quantas pessoas estão no ambiente em relação à capacidade máxima
(50 pessoas).

## Ambiente escolhido
Cinema 🎬

## Integrantes
- Murillo Kenzo Loureiro Kacinvazaki - RM566948

## Vídeo de demonstração
> Cole aqui o link (YouTube, GitHub etc.) do vídeo de até 5 minutos.

## Funcionalidades
- Cadastro de pessoa (nome, ID/matrícula e data/hora de entrada automática)
- Lista de pessoas com situação (**No ambiente** / **Saiu**)
- Deslizar o item para o lado: **SAÍDA** ou **EXCLUIR** (Slidable)
- Confirmação com `AlertDialog` antes de registrar saída ou excluir
- Feedback com `SnackBar` em todas as operações
- Contador de lotação (`12 / 50`) com barra e cores de alerta

### Regras de negócio
1. A lotação nunca ultrapassa a capacidade máxima.
2. Quem já saiu não pode ter a saída registrada de novo.
3. Não cadastra com campos vazios.
4. Não cadastra duas pessoas com o mesmo ID ao mesmo tempo no ambiente.
5. Toda operação mostra feedback ao usuário.

## Como executar
```bash
flutter pub get
dart run flutter_launcher_icons   
flutter run
```

## Tecnologias e pacotes
- Flutter / Dart
- [google_fonts](https://pub.dev/packages/google_fonts)
- [intl](https://pub.dev/packages/intl)
- [flutter_slidable](https://pub.dev/packages/flutter_slidable)
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)

## Estrutura
```
lib/
├── main.dart
├── models/pessoa.dart
├── screens/home_page.dart
├── theme/app_colors.dart
└── widgets/
    ├── pessoa_item.dart
    └── resumo_lotacao.dart
```
