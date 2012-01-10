require 'puppet/face'
require 'puppet/util/settings'

Puppet::Face.define(:completion, '0.0.1') do
  copyright "Puppet Labs", 2011
  license   "Apache 2 license; see COPYING"
  summary "Takes commmand line arguments and returns bash completion information"
  action(:bash) do
    when_invoked do |*args|
      # the puppet/interface/action adds an options hash on the end when the arity isn't clear
      args.pop if args.last == {}
      subcommand = args.shift || ''
      choices = []
      search_pattern = nil

      faces = Puppet::Face.faces.map(&:to_s)
      legacy_applications = Puppet::Face['help', :current].legacy_applications
      settings = Puppet.settings.map {|name, value| name.to_s }.sort.map {|name| "--" + name }

      if faces.include?(subcommand)
        face = Puppet::Face[subcommand, :current]
        actions = face.actions.map(&:to_s)
        options = face.options.map {|o| "--#{o}"}
        choices = (actions + options).sort
        search_pattern = args.last || ''
      elsif legacy_applications.include?(subcommand)
        search_pattern = args.last || ''
      elsif args.empty?
        choices = (faces + legacy_applications).sort
        search_pattern = subcommand
      else
        search_pattern = args.last
      end

      choices << settings if search_pattern =~ /^--/

      return choices, search_pattern
    end
  end
end
