class Tplot::List < Tplot::Plugin

  def execute
    # builtin plugin.
    puts "-- builtin plugins --"
    Dir.glob("#{PLUGIN_DIR}/*.rb").each do |plugin|
      puts_description(plugin, PLUGIN_DIR)
    end

    # user plugin.
    puts "\n-- user plugins --" unless Dir.glob("#{USER_PLUGIN_DIR}/*.rb").empty?
    Dir.glob("#{USER_PLUGIN_DIR}/*.rb").each do |plugin|
      puts_description(plugin, USER_PLUGIN_DIR)
    end
  end

  def puts_description(plugin, dir)
    require plugin
    name = plugin.gsub("#{dir}/", '').gsub(".rb", '')
    plugin_class = Tplot.const_get(name.capitalize)
    puts "tplot #{name}\t: #{plugin_class.description}"
  end

  description "list installed plugins."
  help <<-END
Usage: tplot list
list installed plugins.
END
end
