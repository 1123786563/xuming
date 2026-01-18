import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

/// 续命 (XuMing) App 入口
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // TODO: 初始化 Isar 数据库
  // TODO: 初始化 Supabase
  
  runApp(
    const ProviderScope(
      child: XuMingApp(),
    ),
  );
}
