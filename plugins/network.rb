class Tplot::Network < Tplot::Plugin

  description "plot InOctets/OutOctets"

  def execute
    chart = Tplot::BarChart.new
    chart.labels = %w(InOctets OutOctets)
    
    while true
      values = `cat /proc/net/netstat | tail -n 1 | cut -d" " -f8,9`.split(" ").map{|v| v.strip.to_f}
      inoctet ||= values.first
      outoctet ||= values.last
      chart.add([values.first - inoctet, values.last - outoctet])
      inoctet, outoctet = values.first, values.last
      sleep 1
    end
  end
end
