require 'shoes'

Shoes.app width: 300, height: 200 do
  background white

  # stack do
  #   para "Welcome to the world of Shoes!"
  #   button "Click me" do alert "Nice click!" end
  #   image "http://shoesrb.com/img/shoes-icon.png",
  #         margin_top: 20, margin_left: 10
  # end
  rect(left: 10, top: 10, width: 40)
end
