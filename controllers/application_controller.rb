require 'benchmark'
class ApplicationController
  attr_accessor :params
  def initialize(request=nil)
  	@request = request
  	@threads  = []
  	@hash_of_templates = {}
  	@hell = ["asd","sadasd"]
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
	puts template.inspect
	#threads  = get_binding(:@threads)	
	#puts threads.class
	

	result = template.result(binding)
	
	@hash_of_templates[file_name] = result 
	puts @hash_of_templates
	result# = template.result(binding)
	
	}

	result
	#}
	# file.each do |line|
	# 	eval(line)
	# end 
	# ruby_codes = file.scan(/<%([^<>]*)%>/imu).flatten
	# puts ruby_codes
	# puts file
	# ruby_codes.each_with_index{|code,index|
	# 	file.gsub!(code,"*****#{index}*****")
	# }
	# return file.to_s
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
  ThreadsWait.all_waits(*@threads)
  file  = ""
  file = @threads.map(&:join).map(&:value).join
  puts file
  file
  template = ERB.new(file.encode('UTF-8'))#,0,"")
  result = template.result(binding)
  puts	result.class
  result

end

end
