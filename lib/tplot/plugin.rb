class Tplot::Plugin
  def self.description(description = "")
    @@descriptions ||= {}
    @@descriptions[self] = description if !description.nil? and !description.empty?
    @@descriptions[self]
  end

  def self.help(help = "")
    @@help ||= {}
    @@help[self] = help if !help.nil? and !help.empty?
    @@help[self]
  end

  def execute
    "not implement."
  end
end
