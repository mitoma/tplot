module Tplot
  class BarChart < LineChart
    def draw_line
      tmp_data = @datas.dup
      (-@width..0).map(&:abs).each do |col|
        data = tmp_data.pop
        break unless data

        data_with_idx = []
        data.each_with_index do |value, idx|
          data_with_idx.push [value, idx]
        end
        data_with_idx.sort{|l, r| r.first.abs <=> l.first.abs }.each do |array|
          value, idx = array.first, array.last
          min = calc_position(0)
          max = calc_position(value)
          min, max = max, min if min > max
          (min..max).each do |line|
            setpos(line, col)
            attron(color_pair(COLORS[idx % COLORS.size])|A_NORMAL) do
              addstr("*")
            end
          end
        end
      end
    end
  end
end
