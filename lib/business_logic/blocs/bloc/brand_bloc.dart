import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gestione_brand/data/api_provider.dart';
import 'package:gestione_brand/data/models/brand.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final ApiProvider _apiProvider = ApiProvider();

  BrandBloc() : super(BrandLoading()) {
    on<LoadBrands>(_onLoadBrands);
    on<AddBrand>(_onAddBrands);
    on<UpdateBrand>(_onUpdateBrands);
    on<DeleteBrand>(_onDeleteBrands);
  }

  void _onLoadBrands(LoadBrands event, Emitter<BrandState> emit) async {
    emit(BrandLoading());
    try {
      final brands = await _apiProvider.getBrandList();
      emit(BrandLoaded(brands: brands));
    } catch (e) {
      // emit(PhrasesErrorLoading());
    }
  }

  void _onAddBrands(AddBrand event, Emitter<BrandState> emit) async {
    emit(BrandLoading());
    try {
      // final phrases = await _apiProvider.getPhrases();
      // emit(PhrasesLoaded(phrases: phrases));
    } catch (e) {
      // emit(PhrasesErrorLoading());
    }
  }

  void _onUpdateBrands(UpdateBrand event, Emitter<BrandState> emit) async {
    emit(BrandLoading());
    try {
      // final phrases = await _apiProvider.getPhrases();
      // emit(PhrasesLoaded(phrases: phrases));
    } catch (e) {
      // emit(PhrasesErrorLoading());
    }
  }

  void _onDeleteBrands(DeleteBrand event, Emitter<BrandState> emit) async {
    emit(BrandLoading());
    try {
      // final phrases = await _apiProvider.getPhrases();
      // emit(PhrasesLoaded(phrases: phrases));
    } catch (e) {
      // emit(PhrasesErrorLoading());
    }
  }
}
