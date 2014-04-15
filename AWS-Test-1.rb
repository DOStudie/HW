require 'rubygems'
require 'aws-sdk'
require 'sinatra'

#Create HASH list of all instances and ordere them by given tag in given region
def Instances_By_Tag(region,tag_key)

	ec2 = AWS::EC2.new(:region => region)

	instances_by_tag_value = {}

	instances = ec2.instances.group_by { |inst| inst.tags[tag_key] }.each do |role,instances|
		# puts "#{role}:" #Output current value for tag 'Role'
		instances_for_tag = {}
		instances.each do |inst| #Getting list of all instances for this tag value
			instances_for_tag = instances_for_tag.merge({inst.id => inst.status})
			#puts "   #{inst.id}" #Output all EC2 instances ids with current #{tag_key} tag value
		end 
		if !role then role = "NONE" end #If no value returnung for this tag, "NONE" will be placed as tag value
		instances_by_tag_value = instances_by_tag_value.merge({role => instances_for_tag}) #Adding tag => [instances] to main list
		# puts instances_by_tag_value
	end

	return instances_by_tag_value
end



$is_done = false
$is_running = false
$out_page = ""
$thr = nil

def load_all_html ()
	html_err = "" # Wiill contain error message and will be deplayed if ASW enviromental variable are not set
	html_out = "" # Will conatin HTML with all instances
    tag_key = "role" # By which tag instances will be grouped
	region = "eu-west-1" # From which region instances will be displayed
	aws_id =  ENV['AWS_ACCESS_KEY_ID']
	aws_key = ENV['AWS_SECRET_ACCESS_KEY']



	html_err = "<html><head><title></title></head><body><h1 style=\"text-align: center;\">"
	html_err << "Please set <br>\'AMAZON_ACCESS_KEY_ID\' and \'AMAZON_SECRET_ACCESS_KEY\' <br> enviroment variables"
	html_err << "</h1><br><br></body></html>"
	
	instances_by_tag_value = Instances_By_Tag(region,tag_key)
	# ec2 = AWS::EC2.new(:region => region)

	#START - Building output html that will be put in html_out
	html_out = "<html><head><title>List of AWS instances by -= #{tag_key} =-</title></head>\n<body>"
	html_out << "<h1 style=\"text-align: center;\">List of all AWS instances in region \"#{region}\"<br>"
	html_out << "for Key \"#{aws_id}\" grouped by tag \"#{tag_key}\"</h><br><br>"

	instances_by_tag_value.each do |tag_value,instances_for_tag_value| #Getting hashes of tags and instances
		html_out << "\n<table align=\"center\" border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width: 500px;\">"
		html_out << "<caption><b><b>#{tag_key}: #{tag_value.to_s}<\/b><\/b></caption>"

		instances_for_tag_value.each do |id,stat| #Getting list of instances for current tag
			# ins = ec2.instances[i]
			html_out << "\n<thead><tr>"
			html_out << "<th scope=\"col\"><a href=\"\/instances\/#{id}\">#{id}</a></p></th>" #Shows instance id with link
			html_out << "<th scope=\"col\">#{stat}</th>" #Shows instance status
			html_out << "<th scope=\"col\">#{region}</th>" #Shows region
			html_out << "</tr></thead>\n"
		end #instances_for_tag_value.each

		html_out << "\n</table><br><br>"

	end # instances_by_tag_value.each

	html_out << "\n</body></html>"

	$is_done = true

	if !aws_id or !aws_key # Check if AWS enviroment variables are set
		$out_page = html_err
	else
		$out_page = html_out
	end
	#END - Building output html
end # "/"



get '/' do
	tmp_out = "<html><head><meta http-equiv=\"refresh\" content=\"1\"></head><body><h1 style=\"text-align: center;\">Loading...</h></body></html>"

	if $is_done
		$out_page
	elsif $is_running
		tmp_out
	else
		$is_running = true
		$thr = Thread.new { load_all_html() }
		tmp_out
	end
end

# AWS.config({:access_key_id => aws_id,:secret_access_key => aws_key},:region => "eu-west-1")
# AWS.config(:region => "eu-west-1")
#Configure the connection keys

# ec2 = AWS::EC2.new(:region => "eu-west-1")
# #Connect to EC2 namespace

# # ec2.tags.each do |t|
# # 	puts "#{t.key} = #{t.value}"
# # end #Print all available tags in AWS

# batch = AWS::Route53::ChangeBatch.new('hgjhghjg')
# batch << AWS::Route53::DeleteRequest.new('rrttyy.yuri.com.', 'CNAME')
# batch.call
