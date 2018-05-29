# require 'docker'
# require 'pp'

# class CodeRunner
#   def initialize(docker_image)
#     @container = Docker::Container.create('Image' => 'lang/ruby')
#   end
# end

# # container = Docker::Container.create('Image' => 'lang/ruby')
# # container.start
# # image = Docker::Image.build_from_dir('./lang/ruby')
# # pp image

# container = Docker::Container.create(
#   'Image' => '3fd9065eaf02',
#   'OpenStdin' => true
#   # 'StdinOnce' => true
# )
# pp container

# container.start
# str = container.exec(
#   ['ruby', 'main.rb'],
#   stderr: true,
#   stdout: true
# )
# puts str
# container.stop

# container.remove

tes = "puts 'hoge'"

puts tes.gsub("'", "\\\\'")
