import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:loyaltyart/features/admin/admin_controller.dart';
import '../../../auth/auth_controller.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AdminController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Analytics')),
      body: RefreshIndicator(
        onRefresh: () => controller.loadAnalytics(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildStatCard('Total Revenue', 'KES ${controller.totalRevenue.toStringAsFixed(2)}'),
            _buildStatCard('Total Bookings', '${controller.totalBookings}'),
            _buildStatCard('Total Loyalty Scans', '${controller.totalLoyaltyScans}'),

            const SizedBox(height: 16),
            const Text('Top Customers (by points)', style: _titleStyle),
            ...controller.topCustomers.entries.map((entry) => ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(entry.key),
                  trailing: Text('${entry.value} points'),
                )),

            const SizedBox(height: 16),
            const Text('Revenue by Month', style: _titleStyle),
            SizedBox(
              height: 200,
              child: controller.revenueChart.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : _buildBarChart(controller.revenueChart),
            ),

            const SizedBox(height: 16),
            const Text('Bookings by Month', style: _titleStyle),
            SizedBox(
              height: 200,
              child: controller.bookingsChart.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : _buildTimeSeriesChart(controller.bookingsChart),
            ),

            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              onPressed: () async {
                await Provider.of<AuthController>(context, listen: false).signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(List<BarChartGroupData> chartData) {
    return BarChart(
      BarChartData(
        barGroups: chartData,
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSeriesChart(List<Map<String, dynamic>> dataPoints) {
    final List<FlSpot> spots = [];
    final List<DateTime> dates = [];

    for (var i = 0; i < dataPoints.length; i++) {
      final point = dataPoints[i];
      dates.add(point['date']);
      spots.add(FlSpot(i.toDouble(), point['value']));
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index < 0 || index >= dates.length) return const SizedBox.shrink();
                String formatted = DateFormat('MM/dd').format(dates[index]);
                return Text(formatted, style: const TextStyle(fontSize: 10));
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            dotData: FlDotData(show: true),
            barWidth: 3,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}

const _titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
