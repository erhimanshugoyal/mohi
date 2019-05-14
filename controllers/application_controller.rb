require 'benchmark'
class ApplicationController
  
  attr_accessor :params
  def initialize(request=nil)
  	@request = request
  	@threads  = []
  end

  def self.inherited(other)
    puts "in Application inherited"
  end

  def my_first_page
  	render
    #return "<h1>hello how are you?</h1>"
  end

  def render(file_name = nil)
  	#puts Benchmark.measure {

  	result = ""
  	@threads << Thread.new{
  	if file_name.nil?
		file = File.read("views/"+params[:controller]+"/"+params[:action]+".html.erb") 
	else
		file = File.read("views/"+params[:controller]+"/_"+ file_name +".html.erb")
	end
	template = ERB.new(file,0,"") 
	result = template.result(binding)
	puts result
	result# = template.result(binding)
	
	}

	result
	
  end

 
def remove_binding(var)
	remove_instance_variable(var.to_sym)
end

def get_binding(var)
	eval(var.to_s,binding)
end 

def set_thread_variable(var, value)
	#puts "**********#{var}************"
	#puts "**********#{value.class}**************"
	instance_variable_set(var.to_sym, value)
end

def thread_joiner
  if !@threads.nil?
  ThreadsWait.all_waits(*@threads)
  file  = ""
   puts @threads.inspect
  # order = @threads.map{|th| th.value}
  # puts order.inspect
  file = @threads.map(&:join).map(&:value).join
  file
  template = ERB.new(file.encode('UTF-8'))#,0,"")
  result = template.result(binding)
  p result
  end
end

def render_multi_threaded
  render
  thread_joiner
end

   def self.after(*names)
    names.each do |name|
      m = instance_method(name)
      define_method(name) do |*args, &block|  
        m.bind(self).(*args, &block)
        puts binding.inspect
        yield
      end
    end
  end

 #  after(:render_multi_threaded) { 
	# if !@threads.nil?
	# 	ThreadsWait.all_waits(*@threads)
	# 	file  = ""
	# 	puts @threads.inspect
	# 	# order = @threads.map{|th| th.value}
	# 	# puts order.inspect
	# 	file = @threads.map(&:join).map(&:value).join
	# 	file
	# 	template = ERB.new(file.encode('UTF-8'))#,0,"")
	# 	result = template.result(binding)
	# 	p result
	# else
	# 	p "No thread found"
	# end
 #  }


end
