import 'package:equatable/equatable.dart';

class OnboardingModel extends Equatable {
  const OnboardingModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  List<Object?> get props => [image, title, subtitle];
}
