require 'sinatra'

get '/statuses/:id' do
  puts "insude /statuses/:id"
  text = test(params[:id])
  puts "#{test(params[:id])}"
  erb:status, :locals => {:output_value => text}
end

def test(id)
  if id.to_i != 0
    output_value = case id.to_i
    when 1
      "one"
    when 2
      "two"
    when 3
      "three"
    when 4
      "foure"
    when 5
      "five"
    when 6
      "six"
    when 7
      "seven"
    when 8
      "eight"
    when 9
      "nine"
    when 10
      "ten"
    when 999
      "rr"
    else 
      "No value found!"
    end

    
    # if id.to_i != 999
    #   rr = rr + id.to_s + ":" + output_value.to_s + "\n" #Add to history
    # else
    #   rr ="\n"
    # end
  end
end