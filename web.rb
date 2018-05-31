require 'sinatra'
require 'docker'
require 'pp'
require 'json'

PATH = './files/main.rb'.freeze

puts "#{__dir__}/files"

before do
  headers 'Access-Control-Allow-Origin' => '*'
end

get '/' do
  erb :index
end

get '/run' do
  redirect '/'
end

post '/run' do
  params ||= JSON.parse request.body.read
  File.open(PATH, 'w') do |file|
    file.puts params['code']
  end
  container = Docker::Container.create(
    'Image' => 'c474573555e8',
    'OpenStdin' => true,
    'StdinOnce' => true,
    'HostConfig' => {
      'Mounts' => [
        {
          'Target' => '/tmp/files',
          'Source' => "#{__dir__}/files",
          'Type' => 'bind'
        }
      ]
    }
  )

  container.start
  # params['code'].gsub!(/[']/) { |q| q + '\\' + q + q }
  result = container.exec(
    ['ruby', '/tmp/files/main.rb'],
    stdout: true,
    stderr: true
  )
  # pp result
  container.stop
  container.remove

  { stdout: result[0], stderr: result[1] }.to_json
end
