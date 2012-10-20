class Tplot::List < Tplot::Plugin

  description "list installed plugins."

  def execute
    puts "-- installed plugins --"
    Dir.glob("#{BASE_DIR}/plugins/*.rb").each do |plugin|
      require plugin
      name = plugin.gsub("#{BASE_DIR}/plugins/", '').gsub(".rb", '')
      plugin_class = Tplot.const_get(name.capitalize)
      puts "tplot #{name}\t: #{plugin_class.description}"
    end
  end
end
