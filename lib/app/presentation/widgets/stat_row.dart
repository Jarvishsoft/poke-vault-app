import 'package:poke_vault/app/packages/packages.dart';

class StatRow extends StatelessWidget {
  final String name;
  final int value;
  const StatRow({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(name.toUpperCase(), style: subtitleStyle),
          ),
          SizedBox(width: 30, child: Text(value.toString(), style: valueStyle)),
          const SizedBox(width: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: value / 255,
                minHeight: 8,
                backgroundColor: greyAccent200,
                color: value > 100 ? green : (value > 50 ? orange : red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
