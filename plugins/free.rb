class Tplot::Free < Tplot::Plugin

  def execute
    chart = Tplot::BarChart.new
    chart.labels = [" total ", " used  "]
    
    while true
      uptime = `free | grep Mem`.gsub(/^Mem:/, "").split(" ").map{|v| v.strip.to_f}
      chart.add(uptime[0..1])
      sleep 1
    end
  end

  description "plot free commands result"
  help "Usage: tplot free"
end
