#!/usr/bin/env ruby

fileName = ARGV.first
@text = []
@measurements = ["px", "%", "vw", "vh", "em", "pt"]
@numLines = 0

def compat(line)
  line = "\s\s-webkit-#{line.strip} \n\s\s-moz-#{line.strip} \n\s\s-ms-#{line.strip} \n\s\s-o-#{line.strip}\n"
  @text << line
  @numLines += 1
end

File.open(fileName, "r+").each_line do |line|
  @text << line
  @measurements.any? do |m|
    if line.include?(m)
      compat(line)
    end
  end
end

File.open(fileName, "r+") do |file|
  @text.each do |l|
    file.write(l)
  end
  puts "Compatted #{@numLines} Lines"
end
