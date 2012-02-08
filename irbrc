require "rubygems"
require "interactive_editor"
require "term/ansicolor"
require "wirble"
require "what_methods"

autoload :Benchmark, "benchmark"

# Shortcut to benchmark a block 100,000 times
def quick(count = 100_000)
  Benchmark.bm do |x|
    x.report do
      count.times do
        yield
      end
    end
  end
end

# Extend ANSI coloration
class Color
  extend Term::ANSIColor
end

# Use simple mode
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

# Colorize output
Wirble.init
Wirble.colorize

module DynamicPrompt
  class Info < String
    TEMPLATE = "%s %s %s%s "
    ANSI_CODES = /\e\[\d+(?:;\d+)?m/

    def initialize(opts = {})
      @opts = { :delimiter => " >" }.merge(opts)
    end

    # IRB calls dup on the provided string for each new line of information
    def dup
      TEMPLATE % [cwd, current_ruby, line_number, delimiter]
    end

    private

    # Current working directory
    def cwd
      @@dirs ||= {}
      @@dirs[Dir.pwd] ||= Color.blue(Dir.pwd.start_with?(ENV["HOME"]) ?
                                     Dir.pwd.sub(ENV["HOME"], "~") :
                                     Dir.pwd)
    end

    # Name of current ruby
    def current_ruby
      @@current_ruby ||= Color.red(`rvm current`.strip.sub /^ruby-/, "")
    end

    def line_number
      @@line_number ||= Color.green("%n")
    end

    def delimiter
      @delimiter ||= Color.yellow(@opts[:delimiter])
    end

    # Hide the provided string
    def hide(str)
      " " * str.gsub(ANSI_CODES, "").size
    end
  end

  # Same as above, but gets the correct length of its parameters and blanks them
  # out
  class HiddenInfo < Info
    private

    def cwd;          hide super;                          end
    def current_ruby; hide super;                          end
    def line_number;  @line_number ||= Color.yellow("%n"); end
    def delimiter;    @delimiter   ||= "..";               end
  end

  class << self
    def apply!
      IRB.conf[:PROMPT][:INFORMATIVE] = {
        :PROMPT_I => Info.new,
        :PROMPT_N => Info.new,
        :PROMPT_S => HiddenInfo.new,
        :PROMPT_C => Info.new(:delimiter => "* "),
        :RETURN   => "%s %%s\n" % Color.magenta("# =>")
      }
      IRB.conf[:PROMPT_MODE]  = :INFORMATIVE
    end
  end
end

DynamicPrompt.apply!
