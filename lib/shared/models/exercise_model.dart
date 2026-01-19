import '../../core/router/app_router.dart';

/// 动作修复建议模型
class ExerciseProtocol {
  final String id;
  final String title;
  final String category;
  final String technicalGuide;
  final String imageUrl;
  final String route;
  final String description;
  final List<int> targetPostures; // 0: 久坐办公, 1: 低头码字, 2: 葛优躺刷机

  const ExerciseProtocol({
    required this.id,
    required this.title,
    required this.category,
    required this.technicalGuide,
    required this.imageUrl,
    required this.route,
    required this.description,
    required this.targetPostures,
  });
}

/// 预设动作库
const List<ExerciseProtocol> allProtocols = [
  ExerciseProtocol(
    id: 'SPINE_ALIGN',
    title: '脊椎螺旋对齐',
    category: 'STRUCTURAL_REPAIR',
    technicalGuide: 'Level 5 Relief Protocol',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCeJKoccr-pifHeuOFMaukbeIKQhTKk_wiCw5Kc8DqeppWs1FbBKRdSyd8EptO0fD28EjL2mkITRgJnrtt7vlJpG9sVN1FnbQ7mai8-tdARUChexELhRMxbWwr-T43CUa7QIci81DKXGOPzWRzqemzwzfrQpe1x7Vvwf9QXw3ppkCdc_CWK0aEGa58S9dq4s6SAqOH_fS6aLJbXgqaKWnyyMXGo5gV0NLYBwciO2y_yG-awhOqnjq8igA83gWF9Zw4j_lkKl13ZCXI',
    route: AppRoutes.exercise, // 默认脊椎解压
    description: '针对长期伏案导致的胸椎后突，通过螺旋牵引恢复中轴线稳定性。',
    targetPostures: [0, 1],
  ),
  ExerciseProtocol(
    id: 'NECK_STRETCH',
    title: '颈椎深度拉伸',
    category: 'NEURAL_DECOMPRESSION',
    technicalGuide: 'Cervical Reset Protocol',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBW4G-J5JT-jpXbYMuNjT79oO0bzaIUdf6FW-VISvq6hvLtYlflcETgxhEVia1bu7uyzcihFDYfmCJNFblybpS_Dawt4hgm2MsUVi9NU7vjSwZ70f7PmQ3aCRxPjCeNv1thpHrpo8_A2mop66SeUdm0DekKBSv7dMKmC98ddBjftCZZgzv2wVpDltm1UTa99dIvYv-Y65pSu4H_2wzBCuWo-lKIObA850Crm_6A6VCREFLa_e9dXWOxbL9epw-m9HrI-cRek7tSwXw',
    route: AppRoutes.neckFirstAid,
    description: '缓解因低头使用电子设备造成的寰枢关节压力，通过精准牵拉释放痛点。',
    targetPostures: [1, 2],
  ),
  ExerciseProtocol(
    id: 'WRIST_FLUSH',
    title: '掌骨压力排空',
    category: 'CARPAL_FLUSH',
    technicalGuide: 'Manual Data Flush V2',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCwc0Bt4oqM_QyY8ZjFu7pKSPfMP3Ks7N4Oa2HqQifj9aDTAMZ7vJedzlpgtf7hLoUkJL9Z3jwe6WuJ55WagIWOjJzAeafFbBLEESWCUKwQUOsNrOtR3NuoX6IKAkDWvCw7tThhHJ9WH64B_OGgUZv1Zwl-Xmt3fhTt6I7-0S54SzYL4B-U6s2bxT62XAAtFEFvsCCuWIE_hqc9lBSq2u5P45dYiIHNsoPUJwFYdGri9jOdE6Sy2mJ1KjCaaMvuGdM6ltIEzt4D4pQ',
    route: AppRoutes.metacarpalPressureFlush,
    description: '针对鼠标手和长期键入引起的筋膜黏连，通过掌骨排空增强远端血液循环。',
    targetPostures: [0],
  ),
  ExerciseProtocol(
    id: 'GLUTE_ACTIVATE',
    title: '臀部机能唤醒',
    category: 'BIO_MOTOR_INIT',
    technicalGuide: 'Pelvic Stability Protocol',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuByS-bO63_z1pEaP-2hOq9C9tEa94vC_E93_w3_-qI9z197-Y_6X7-_3w7_e7_-3P7_-0_-1_-2_-3_-4_-5_-6_-7_-8_-9',
    route: AppRoutes.gluteActivation,
    description: '唤醒因久坐导致的臀大肌失忆，建立强健的下肢生命支撑系统。',
    targetPostures: [0, 2],
  ),
  ExerciseProtocol(
    id: 'STOMACH_VACUUM',
    title: '隐形练腹潜行',
    category: 'CORE_STEALTH',
    technicalGuide: 'Transverse Abdominis Reset',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC9-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_',
    route: AppRoutes.stealthStomachVacuum,
    description: '在工作中隐形启动深层核心，改善因不良坐姿导致的腹部肌肉松弛。',
    targetPostures: [0, 1, 2],
  ),
];
