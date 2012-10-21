class Tplot::Help < Tplot::Plugin

  description "print plugins help."

  def execute
    plugin_name = ARGV.shift
    if File.exists?("#{PLUGIN_DIR}/#{plugin_name}.rb")
      print_help("#{PLUGIN_DIR}/#{plugin_name}.rb", PLUGIN_DIR)
      exit 0
    end    
    if File.exists?("#{USER_PLUGIN_DIR}/#{plugin_name}.rb")
      print_help("#{PLUGIN_DIR}/#{plugin_name}.rb", USER_PLUGIN_DIR)
      exit 0
    end    
  end

  def print_help(plugin_path, dir)
    require plugin_path
    name = plugin_path.gsub("#{dir}/", '').gsub(".rb", '')
    plugin_class = Tplot.const_get(name.capitalize)
    return puts plugin_class.help.call if plugin_class.help.is_a? Proc
    return puts plugin_class.help
  end
end
