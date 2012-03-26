load File.join(File.expand_path(File.dirname(__FILE__)), ".irbrc")

Pry.config.commands.import Pry::ExtendedCommands::Experimental
