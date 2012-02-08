require "rubygems"
require "interactive_editor"
require "term/ansicolor"
require "wirble"

autoload :Benchmark, "benchmark"

# Shortcut to benchmark a block 1,000 times
def quick(count = 1_000)
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

# Auto-indent everything
IRB.conf[:AUTO_INDENT] = true

# Colorize output
Wirble.init
Wirble.colorize

module DynamicPrompt
  class << self
    def apply!
      IRB.conf[:PROMPT][:INFORMATIVE] = {
        :PROMPT_I => ">>".tap {|s| def s.dup; gsub('>>', DynamicPrompt.normal); end },
        :PROMPT_S => Color.red { "" },
        :PROMPT_C => "",
        :RETURN => "\e# =>\e[0m %.2048s\n"
      }
      IRB.conf[:PROMPT_MODE]  = :INFORMATIVE
    end

    def normal
      "%s %s %s > " % [Color.blue(cwd),
                       Color.red(current_ruby),
                       Color.green("%n")]
    end

    private

    # Name of current ruby
    def current_ruby
      @current_ruby ||= `rvm current`.strip.sub /^ruby-/, ""
    end

    # Current working directory
    def cwd
      @dirs ||= {}

      @dirs[Dir.pwd] ||= if Dir.pwd.start_with?(ENV["HOME"])
                           Dir.pwd.sub ENV["HOME"], "~"
                         else
                           Dir.pwd
                         end
    end
  end
end

DynamicPrompt.apply!
