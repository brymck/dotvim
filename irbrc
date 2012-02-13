unless defined?(CUSTOM_IRBRC_LOADED)
  require "rubygems"
  require "interactive_editor"
  require "irb/completion"
  require "term/ansicolor"
  require "wirble"
  require "what_methods"

  # Determine whether to show patch information
  @@show_patch = false
  def show_patch;  @@show_patch = true;  $current_ruby.clear; end
  def hide_patch;  @@show_patch = false; $current_ruby.clear; end
  def show_patch?; @@show_patch; end

  # Determine whether to show the full path to the current working directory
  @@show_path = false
  def show_path;  @@show_path = true;  @@dirs.clear; end
  def hide_path;  @@show_path = false; @@dirs.clear; end
  def show_path?; @@show_patch; end

  autoload :Benchmark, "benchmark"

  # Re-require gems easily
  def reload(require_regex)
    $".grep(/^#{require_regex}/).each {|e| $".delete(e) && require(e) }
  end

  # Setup permanent history.
  HISTFILE = "~/.irb_history"
  MAXHISTSIZE = 100
  begin
    histfile = File::expand_path(HISTFILE)
    if File::exists?(histfile)
      lines = IO::readlines(histfile).collect { |line| line.chomp }
      puts "Read #{lines.size} saved history commands from '#{histfile}'." if $VERBOSE
      Readline::HISTORY.push(*lines)
    else
      puts "History file '#{histfile}' was empty or non-existant." if $VERBOSE
    end
    Kernel::at_exit do
      lines = Readline::HISTORY.to_a.reverse.uniq.reverse
      lines = lines[-MAXHISTSIZE, MAXHISTSIZE] if lines.size > MAXHISTSIZE
      puts "Saving #{lines.length} history lines to '#{histfile}'." if $VERBOSE
      File::open(histfile, File::WRONLY|File::CREAT|File::TRUNC) { |io| io.puts lines.join("\n") }
    end
  rescue => e
    puts "Error when configuring permanent history: #{e}" if $VERBOSE
  end

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
        return @@dirs[Dir.pwd] unless @@dirs[Dir.pwd].nil?

        path = Dir.pwd.start_with?(ENV["HOME"]) ?
               Dir.pwd.sub(ENV["HOME"], "~") :
               Dir.pwd
        path = path.split("/").last unless show_path?
        @@dirs[Dir.pwd] = Color.blue(path)
      end

      # Name of current ruby
      def current_ruby
        $current_ruby ||= ""
        return $current_ruby unless $current_ruby.empty?

        curr_ruby = `rvm current`.strip.sub(/^ruby-/, "")
        curr_ruby = curr_ruby.sub(/\-p\d+$/, "") unless show_patch?
        $current_ruby = Color.red(curr_ruby)
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

  CUSTOM_IRBRC_LOADED = true
end
