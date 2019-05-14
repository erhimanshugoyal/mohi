require 'webrick'
require 'thread'
require 'thwait'

load 'lib/action_controller/base.rb'
load 'controllers/application_controller.rb'
Dir["controllers/*.rb"].sort.each {|file|  load file }

route_file = File.read('config/routes.rb').strip
routes = eval(route_file)

root = File.expand_path 'public/'
server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root


module StringMethod

def constantize
  self.split('_').map{|x| x[0] = x[0].upcase + x[1..-1]}.join('')
end

end

String.class_eval {include StringMethod}


routes.each{|route_name,controller_action|
server.mount_proc route_name do |req, res|
  controller_name,action = controller_action.split('#')
  puts controller_name
  controller = Kernel.const_get((controller_name+"_controller").constantize)
  object = controller.new(req)
  object.params = {controller: controller_name, action: action}
  res.body = object.send(action)
end  
}




trap 'INT' do server.shutdown end

# server.mount_proc '/himanshu' do |req, res|
#   puts req.inspect
#   res.body = 'Hello, world!'
# end

# server.mount_proc '/first' do |req, res|
#   res.body = ApplicationController.new.my_first_page
# end

server.start
