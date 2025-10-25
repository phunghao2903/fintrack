import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fintrack/features/chart/datasources/chart_data_source.dart';
import 'package:fintrack/features/chart/models/chart_data.dart';

part 'chart_event.dart';
part 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  ChartBloc() : super(ChartState.initial()) {
    on<LoadChartDataEvent>(_onLoadData);
    on<ChangeFilterEvent>(_onChangeFilter);
  }

  void _onLoadData(LoadChartDataEvent event, Emitter<ChartState> emit) {
    final data = ChartDataSource.getDataByFilter(state.selectedFilter);
    emit(state.copyWith(chartData: data));
  }

  void _onChangeFilter(ChangeFilterEvent event, Emitter<ChartState> emit) {
    // Lấy dữ liệu theo filter mới
    final data = ChartDataSource.getDataByFilter(event.filter);
    emit(state.copyWith(selectedFilter: event.filter, chartData: data));
  }
}
