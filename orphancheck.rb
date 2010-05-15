links = Array.new
orphans = Array.new
dir_array = [Dir.getwd]

unless File.readable?("links.txt")
  puts "File is not readable"
  exit
end

File.open('links.txt', 'rb') do |lv|
  lv.each_line do |line|
    links << line.chomp
  end
end

begin
  p = dir_array.shift
  Dir.chdir(p)
  
  Dir.foreach(p) do |filename|
    next if filename == '.' or filename == '..'
    if !File::directory?(filename)
      orphans << p + File::SEPARATOR + filename
    else
      dir_array << p + File::SEPARATOR + filename
    end
  end
end while !dir_array.empty?

orphans -= links

File.open('orphans.txt', 'wb') do |o|
  o.puts orphans
end