module Tplot
  class BarChart
    include Curses

    COLORS = [COLOR_BLUE,
              COLOR_GREEN,
              COLOR_RED,
              COLOR_CYAN,
              COLOR_MAGENTA,
              COLOR_YELLOW,
              COLOR_WHITE]

    attr_accessor :labels
    attr_accessor :limit

    def initialize
      @labels = []
      @datas ||= []
      @limit = 800
    end

    def add(values)
      @datas.push(values)
      @datas.shift if @datas.size > limit
      draw
    end

    def update(values)
      @datas.pop
      @datas.push(values)
      draw
    end

    def draw
      pre_draw

      draw_frame_pre
      draw_line
      draw_frame_post
      
      setpos(0, 0)
      refresh
    end

    def pre_draw
      clear
      start_color
      init_colors

      @min_value = (@datas.flatten.min < 0) ? @datas.flatten.min : 0
      @max_value = (@datas.flatten.max < 0) ? 1 : @datas.flatten.max

      @height = lines - 1
      @width = cols - 1
    end

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
              addstr(" ")
            end
          end
        end
      end
    end

    def print_char(v)
      if v.even?
        return "_"
      else
        return "-"
      end
    end

    def calc_mapping_value(value)
      range = (@max_value - @min_value).abs
      ratio = (value - @min_value).abs.to_f / range.to_f
      (@height * ratio * 2).to_i
    end

    def calc_position(value)
      range = (@max_value - @min_value).abs
      ratio = (value - @min_value).abs.to_f / range.to_f
      (@height * (1 - ratio)).to_i
    end

    def draw_frame_pre
      setpos(calc_position(@max_value), 0)
      addstr(print_char(calc_mapping_value(@max_value)) * (@width + 1))

      setpos(calc_position(0), 0)
      addstr(print_char(calc_mapping_value(0)) * (@width + 1))

      setpos(calc_position(@min_value), 0)
      addstr(print_char(calc_mapping_value(@min_value)) * (@width + 1))
    end

    def draw_frame_post
      setpos(calc_position(@max_value), 0)
      addstr(@max_value.to_s)

      setpos(calc_position(0), 0)
      addstr(0.to_s)

      setpos(calc_position(@min_value), 0)
      addstr(@min_value.to_s)

      labels.each_with_index do |label, idx|
        setpos(idx + 2, 2)
        attron(color_pair(COLORS[idx % COLORS.size])|A_NORMAL) do
          addstr(label)
        end
      end

    end

    def init_colors
      COLORS.each_with_index do |col,idx|
        init_pair(col, COLOR_BLACK, col)
      end
    end
  end
end