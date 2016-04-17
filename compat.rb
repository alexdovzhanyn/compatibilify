#!/usr/bin/env ruby

fileName = ARGV.first
@text = []

def compat(line)
  line = "\s\s-webkit-#{line.strip} \n\s\s-moz-#{line.strip} \n\s\s-ms-#{line.strip} \n\s\s-o-#{line.strip}\n"
  print line
  @text << line
end

File.open(fileName, "r+").each_line do |line|
  @text << line
  if line.include? "px"
    compat(line)
  elsif line.include? "%"
    compat(line)
  elsif line.include? "vw"
    compat(line)
  elsif line.include? "vh"
    compat(line)
  elsif line.include? "em"
    compat(line)
  elsif line.include? "pt"
    compat(line)
  end
end

File.open(fileName, "r+") do |file|
  @text.each do |l|
    file.write(l)
  end
end
