require 'sinatra'
require 'docker'
require 'pp'
require 'json'

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
  # image = Docker::Image.build_from_dir('./lang/ruby')
  # container = Docker::Container.create(
  #   'Image' => '452a96d81c30',
  #   'OpenStdin' => true
  #   # 'StdinOnce' => true
  # )
  container = Docker::Container.get('c2c936782e5c')
  # pp container

  container.start
  # container.exec(
  #   ['rm', 'main.rb']
  # )
  # container.exec(
  #   ['touch', 'main.rb']
  # )
  # container.exec(['echo', "#{params[:code]} > main.rb"])

  params ||= JSON.parse request.body.read
  params['code'].gsub!(/[']/) { |q| q + '\\' + q + q }
  pp params['code']
  command = "ruby -e '#{params['code']}'"
  pp command
  puts command
  result = container.exec(
    ['bash', '-c', command],
    stderr: true,
    stdout: true
  )
  # pp result
  container.stop

  { stdout: result[0], stderr: result[1] }.to_json
end
