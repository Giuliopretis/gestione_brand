part of 'brand_bloc.dart';

abstract class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class BrandLoading extends BrandState {
  @override
  List<Brand> get props => [];
}

class BrandLoaded extends BrandState {
  final List<Brand> brands;

  const BrandLoaded({required this.brands});

  @override
  List<Brand> get props => [];
}

class BrandLoadingError extends BrandState {
  final String message = 'There was an error on loading list';
  @override
  List<String> get props => [message];
}
