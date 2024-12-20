import 'package:flutter/material.dart';

class AnimatedFab extends StatefulWidget {
  const AnimatedFab({super.key});

  @override
  State<AnimatedFab> createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _expansionController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _expansionAnimation;
  bool _isVisible = false; // Флаг для управления видимостью кнопки
  bool _isExpanded = false; // Флаг для отслеживания состояния кнопки
  @override

  void initState() {
    super.initState();

    // Контроллер для анимации вращения
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * 3.1415927 * 3).animate(
          CurvedAnimation(parent: _rotationController, curve: Curves.ease),
        );

    // Контроллер для анимации расширения кнопки
    _expansionController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _expansionAnimation = Tween<double>(begin: 56.0, end: 200.0).animate(
      CurvedAnimation(parent: _expansionController, curve: Curves.easeOut),
    );

    // Задержка перед началом появления кнопки
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true; // Показываем кнопку через AnimatedOpacity
      });
    });
  }
  @override
  void dispose() {
    _rotationController.dispose();
    _expansionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1 : 0, // Плавное появление кнопки
      duration: const Duration(milliseconds: 500),
      onEnd: () {
        // После появления кнопки запускаем остальные анимации
        _rotationController.forward().then((_) {
          setState(() {
            _isExpanded = true; // Обновляем состояние для расширения кнопки
            _expansionController.forward();
          });
        });
      },
      child: AnimatedBuilder(
        animation:
        Listenable.merge([_rotationController, _expansionController]), //доделать
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: _rotationAnimation.value, // Применяем вращение
            child: SizedBox(
              width: _expansionAnimation.value, // Плавное расширение
              child: FloatingActionButton.extended(
                label: _isExpanded
                    ? FadeTransition(
                  opacity: _expansionController,
                  child: const Text("Create Task"),
                )
                    : const SizedBox.shrink(),
                // Показываем текст только если кнопка расширена
                icon: const Icon(Icons.edit_note_outlined),
                backgroundColor: Colors.greenAccent,
                onPressed: () {
                  Navigator.pushNamed(context, '/new_task_screen');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
