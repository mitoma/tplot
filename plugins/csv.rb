class Tplot::Csv < Tplot::Plugin

  def initialize
    require 'csv'
    @options = {
      chart_type: Tplot::BarChart,
      delay: 1,
      use_header: false
    }
  end

  def parser
    OptionParser.new do |opt|
      opt.banner = "Usage: tplot csv csv_file [options]\n"
      opt.on('-l', '--line','line chart.') do
        @options[:chart_type] = Tplot::LineChart
      end
      opt.on('-h', '--header','set header first row') do
        @options[:use_header] = true
      end
    end
  end

  def execute
    parser.parse!(ARGV)
    file_name = ARGV.shift

    chart = @options[:chart_type].new
    CSV.foreach(file_name) do |csv|
      if @options[:use_header]
        chart.labels = ["hoge","moge"]
        @options[:use_header] = false
        next
      end
      chart.add(csv.map(&:to_f))
    end
    chart.draw
  end

  description "plot csv file"
  help self.new.parser.to_s
end
