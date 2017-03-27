require 'rubygems'
require 'pdf/reader'
require 'pathname'

def name_matches_filename(file_path)
  File.open(file_path, 'rb') do |io|
    reader = PDF::Reader.new(io)
    reader.pages.each do |page|
      names = File.basename(file_path, '.pdf').split('_')
      return false unless page.text.include?(names[0]) && page.text.include?(names[1])
    end
  end
  true
end

matches = 0
total_files = 0

Dir['pdfs/*.pdf'].each do |f|
  total_files += 1
  if name_matches_filename(f)
    matches += 1
  else
    puts "File: #{f} - Name is not included in the PDF text."
  end
end

puts "#{matches} of #{total_files} files match"
