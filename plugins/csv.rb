class Tplot::Csv < Tplot::Plugin

  def initialize
    require 'csv'
    @options = {
      chart_type: Tplot::BarChart,
      use_header: false,
      fields: nil
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
      opt.on('-f FIELD', '--field=FIELD','use field ex) -f 1,3,5') do |field|
        @options[:fields] = field.split(',').map(&:to_i)
      end
    end
  end

  def execute
    parser.parse!(ARGV)
    file_name = ARGV.shift

    chart = @options[:chart_type].new
    CSV.foreach(file_name) do |csv|
      if @options[:fields]
        data = (1..csv.size).inject([]) do |arr, i|
          @options[:fields].include?(i) ? arr.push(csv[i - 1]) : arr
        end
      else
        data = csv
      end

      if @options[:use_header]
        chart.labels = data
        @options[:use_header] = false
        next
      end

      chart.add(data.map(&:to_f))
    end
    chart.draw
  end

  description "plot csv file"
  help self.new.parser.to_s
end
