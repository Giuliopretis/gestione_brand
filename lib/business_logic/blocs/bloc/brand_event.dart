part of 'brand_bloc.dart';

abstract class BrandEvent extends Equatable {
  const BrandEvent();

  @override
  List<Object> get props => [];
}

class LoadBrands extends BrandEvent {
  @override
  List<Object> get props => [];
}

class AddBrand extends BrandEvent {
  final Brand brand;

  const AddBrand({required this.brand});

  @override
  List<Object> get props => [brand];
}

class UpdateBrand extends BrandEvent {
  final Brand brand;

  const UpdateBrand({required this.brand});

  @override
  List<Object> get props => [brand];
}

class DeleteBrand extends BrandEvent {
  final Brand brand;

  const DeleteBrand({required this.brand});

  @override
  List<Object> get props => [brand];
}
