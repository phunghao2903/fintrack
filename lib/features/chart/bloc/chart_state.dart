part of 'chart_bloc.dart';

class ChartState extends Equatable {
  final String selectedFilter;
  final List<ChartData> chartData;

  const ChartState({required this.selectedFilter, required this.chartData});

  factory ChartState.initial() {
    return const ChartState(selectedFilter: "Daily", chartData: []);
  }

  ChartState copyWith({String? selectedFilter, List<ChartData>? chartData}) {
    return ChartState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      chartData: chartData ?? this.chartData,
    );
  }

  @override
  List<Object?> get props => [selectedFilter, chartData];
}
