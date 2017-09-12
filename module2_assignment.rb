# Implement all parts of this assignment within (this) module2_assignment2.rb file

# Implement a class called LineAnalyzer.
class LineAnalyzer
  attr_reader :content, :line_number, :highest_wf_words, :highest_wf_count

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_words = []
    calculate_word_frequency
  end

  def calculate_word_frequency
    word_frequency = Hash.new(0)
    @content.split.each do |word|
      word_frequency[word.downcase] += 1
    end
    @highest_wf_count = word_frequency.values.max
    word_frequency.each do |k, v|
      @highest_wf_words << k if @highest_wf_count == v
    end
  end
end

class Solution
  attr_reader :highest_count_across_lines, :highest_count_words_across_lines, :analyzers

  def initialize
    @analyzers = []
  end

  def analyze_file
    count = 0
    File.foreach('test.txt') do |line|
      @analyzers << LineAnalyzer.new(line.chomp, count += 1)
    end
  end

  def calculate_line_with_highest_frequency
    @highest_count_across_lines = @analyzers.max_by(&:highest_wf_count).highest_wf_count
    @highest_count_words_across_lines = []
    @analyzers.each do |la|
      @highest_count_words_across_lines << la if la.highest_wf_count == @highest_count_across_lines
    end
  end

  def print_highest_word_frequency_across_lines
    @highest_count_words_across_lines.each_pair do |line, words|
      words.each { |w| puts w }
      puts line
    end
  end
end
