import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Boss Mode 伪装界面
class BossModePage extends StatefulWidget {
  const BossModePage({super.key});

  @override
  State<BossModePage> createState() => _BossModePageState();
}

class _BossModePageState extends State<BossModePage> {
  bool _isExcel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isExcel ? const Color(0xFFF3F3F3) : const Color(0xFF1E1E1E),
      body: GestureDetector(
        onTap: () {
          // 点击任意位置返回（或者点击特定装饰位）
          context.pop();
        },
        onDoubleTap: () {
          // 双击切换 Excel/VS Code 伪装
          setState(() => _isExcel = !_isExcel);
        },
        child: _isExcel ? _buildExcelMock() : _buildVSCodeMock(),
      ),
    );
  }

  Widget _buildVSCodeMock() {
    return Column(
      children: [
        // 顶部标签栏
        Container(
          height: 35,
          color: const Color(0xFF252526),
          child: Row(
            children: [
              _buildTab("main.dart", true),
              _buildTab("app_router.dart", false),
              _buildTab("dashboard.dart", false),
            ],
          ),
        ),
        // 代码内容
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _codeLine("1", "import 'package:flutter/material.dart';", const Color(0xFFC586C0)),
                _codeLine("2", "", Colors.white),
                _codeLine("3", "class XuMingDashboard extends StatelessWidget {", const Color(0xFF4FC1FF)),
                _codeLine("4", "  @override", const Color(0xFFDCDCAA)),
                _codeLine("5", "  Widget build(BuildContext context) {", const Color(0xFFDCDCAA)),
                _codeLine("6", "    return Container(", Colors.white),
                _codeLine("7", "      child: const Text('Initializing...'),", const Color(0xFFCE9178)),
                _codeLine("8", "    );", Colors.white),
                _codeLine("9", "  }", Colors.white),
                _codeLine("10", "}", Colors.white),
                _codeLine("11", "", Colors.white),
                _codeLine("12", "// TODO: Implement high-performance data processing", const Color(0xFF6A9955)),
                _codeLine("13", "void _processData(List<dynamic> logs) {", const Color(0xFFDCDCAA)),
                _codeLine("14", "  logs.forEach((log) => print(log));", Colors.white),
                _codeLine("15", "}", Colors.white),
              ],
            ),
          ),
        ),
        // 底部状态栏
        Container(
          height: 22,
          color: const Color(0xFF007ACC),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Main*  UTF-8  Dart", style: TextStyle(color: Colors.white, fontSize: 11)),
              Text("Ln 14, Col 32", style: TextStyle(color: Colors.white, fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExcelMock() {
    return Column(
      children: [
        // 顶部 Ribbon 占位
        Container(
          height: 80,
          color: const Color(0xFF217346),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Home  Insert  Page Layout  Formulas  Data", style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ),
        // 表格内容
        Expanded(
          child: Container(
            color: Colors.white,
            child: Column(
              children: List.generate(15, (row) {
                return Row(
                  children: List.generate(6, (col) {
                    return Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFD0D0D0)),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        row == 0 ? "Column ${String.fromCharCode(65 + col)}" : (col == 0 ? "Item $row" : "1,234.00"),
                        style: TextStyle(
                          color: row == 0 ? Colors.black : Colors.black87,
                          fontSize: 12,
                          fontWeight: row == 0 ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
          ),
        ),
        // 底部 Sheet 栏
        Container(
          height: 30,
          color: const Color(0xFFF3F3F3),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: const Row(
            children: [
              Text("Sheet1  Sheet2  Sheet3", style: TextStyle(color: Colors.black, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String title, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: isActive ? const Color(0xFF1E1E1E) : const Color(0xFF2D2D2D),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white54,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _codeLine(String num, String content, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(num, style: const TextStyle(color: Color(0xFF858585), fontSize: 12, fontFamily: 'monospace')),
          ),
          const SizedBox(width: 8),
          Text(content, style: TextStyle(color: textColor, fontSize: 13, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}
