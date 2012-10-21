# -*- coding: utf-8 -*-
class Tplot::Uptime < Tplot::Plugin

  def initialize
    @options = {
      chart_type: Tplot::BarChart,
      delay: 1
    }
  end

  def parser
    OptionParser.new do |opt|
      opt.banner = "Usage: tplot uptime [options]\n"
      opt.on('-l', '--line','line chart.') do
        @options[:chart_type] = Tplot::LineChart
      end
      opt.on('-n N', '--delay=N', 'set interval.') do |n|
        @options[:delay] = n.to_i
      end
    end
  end

  def execute
    parser.parse!(ARGV)

    chart = @options[:chart_type].new
    chart.labels = ["  1min  ", "  5min  ", " 15min  "]
    
    while true
      uptime = `uptime`.gsub(/^.*load average: /, "").split(",").map{|v| v.strip.to_f}
      chart.add(uptime)
      sleep @options[:delay]
    end
  end

  description "plot uptime commands result"
  help self.new.parser.to_s
end
