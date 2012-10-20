class Tplot::Uptime < Tplot::Plugin

  description "plot uptime commands result"

  def execute
    chart = Tplot::LineChart.new
    chart.labels = %w(1min 5min 15min)
    
    while true
      uptime = `uptime`.gsub(/^.*load average: /, "").split(",").map{|v| v.strip.to_f}
      chart.add(uptime)
      sleep 1
    end
  end
end
