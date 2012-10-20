class Tplot::Free < Tplot::Plugin

  description "plot free commands result"

  def execute
    chart = Tplot::LineChart.new
    chart.labels = %w(total used free shared buffers cached)
    
    while true
      uptime = `free | grep Mem`.gsub(/^Mem:/, "").split(" ").map{|v| v.strip.to_f}
      chart.add(uptime)
      sleep 1
    end
  end
end
