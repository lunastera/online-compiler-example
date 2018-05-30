require 'docker'
require 'pp'

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

container = Docker::Container.get('c2c936782e5c')
container.start
# str = container.exec(
#   ['bash', '-c', 'echo "puts \'hoge\'" >> main.rb'],
#   stdout: true
# )
str = container.exec(
  ['ruby', 'main.rb'],
  stdout: true
)
pp str
container.stop
