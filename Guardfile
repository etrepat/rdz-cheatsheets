require 'bundler/setup'
Bundler.require

require 'fileutils'
require 'rocco'

guard 'shell' do
  watch(%r{^(lib/.+\.rb)$}) do |match|
    source_file = match.to_s
    dest_file   = source_file.sub(Regexp.new("#{File.extname(source_file)}$"),".html")
    dest_file   = File.join('public/', dest_file)

    puts "rocco: #{source_file} -> #{dest_file}"

    rocco = Rocco.new(source_file, ['lib/**/*.rb'])
    FileUtils.mkdir_p File.dirname(dest_file)
    File.open(dest_file, 'wb') { |f| f.write(rocco.to_html) }
  end
end
