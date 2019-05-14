module Base
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

after(*instance_methods) { puts "start" }


end

module Base
 #   def render(file_name = nil)
 #  	#puts Benchmark.measure {

 #  	result = ""
 #  	@threads << Thread.new{
 #  	if file_name.nil?
	# 	file = File.read("views/"+params[:controller]+"/"+params[:action]+".html.erb") 
	# else
	# 	file = File.read("views/"+params[:controller]+"/_"+ file_name +".html.erb")
	# end
	# template = ERB.new(file,0,"")
	# puts @threads.inspect
	# #threads  = get_binding(:@threads)	
	# #puts threads.class
	# @count = @count + 1
	# thread = Thread.current
	# thread[:count] = @count 
	# result = template.result(binding)
	
	# result# = template.result(binding)
	
	# }

	# result
	# #}
	# # file.each do |line|
	# # 	eval(line)
	# # end 
	# # ruby_codes = file.scan(/<%([^<>]*)%>/imu).flatten
	# # puts ruby_codes
	# # puts file
	# # ruby_codes.each_with_index{|code,index|
	# # 	file.gsub!(code,"*****#{index}*****")
	# # }
	# # return file.to_s
 #  end

 #  def thread_joiner
 #  ThreadsWait.all_waits(*@threads)
 #  file  = ""
 #  puts @threads.inspect
 #  order = @threads.map{|th| th.value}
 #  puts order.inspect
 #  file = @threads.map(&:join).map(&:value).join
 #  file
 #  template = ERB.new(file.encode('UTF-8'))#,0,"")
 #  result = template.result(binding)
 #  result

	# end

	# def render_multi_thread

	# 	eval(":@ThreadsWait",binding)

	# end

	# after(*instance_methods) { 
	#   ThreadsWait.all_waits(*@threads)
	#   file  = ""
	#   puts "$$$$$$$$$$$$$$$$$$$$$$"
	#   puts @threads.inspect
	#   puts "$$$$$$$$$$$$$$$$$$$$$$"
	#   order = @threads.map{|th| th.value}
	#   puts order.inspect
	#   file = @threads.map(&:join).map(&:value).join
	#   file
	#   template = ERB.new(file.encode('UTF-8'))#,0,"")
	#   result = template.result(binding)
	#   p result
	# }
  #after(*instance_methods) { thread_joiner }

	
end