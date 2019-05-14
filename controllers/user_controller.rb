class UserController <  ApplicationController

def index
   @my_array = [1,2,3,4]
    self.inspect
    render
end

def show
 render
end

#def render(file_name = nil)
	# file = File.read("views/"+params[:controller]+"/"+params[:action]+".html.erb") 
	# template = ERB.new(file,0,"")
	# template.result(binding)
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
#end

end