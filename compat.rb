#!/usr/bin/env ruby

fileName = ARGV.first
@text = []
@measurements = ["px", "%", "vw", "vh", "em", "pt"]
@numLines = 0
@prefixes = ["-webkit-", "-moz-", "-ms-", "-o-"]
@prevLine = ""

def compat(writeLine)
  writeLine = "\s\s-webkit-#{writeLine.strip} \n\s\s-moz-#{writeLine.strip} \n\s\s-ms-#{writeLine.strip} \n\s\s-o-#{writeLine.strip}\n"
  @text << writeLine
  @numLines += 1
end

File.open(fileName, "r+").each_line do |line|
  @text << @prevLine
  @prevHasPref = false
  @lineHasPref = false
  @prefixes.any? do |pr|
    if @prevLine.include?(pr)
      @prevHasPref = true
    end

    if line.include?(pr)
      @lineHasPref = true
    end
  end
  @measurements.any? do |m|
    if @prevLine.include?(m) && !@prevHasPref
      if !@lineHasPref
        compat(@prevLine)
      end
    end
  end
  @prevLine = line
end

File.open(fileName, "r+") do |file|
  @text.each do |l|
    file.write(l)
  end
  file.write("}")
  puts "Compatted #{@numLines} Lines"
end
