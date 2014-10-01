class HomeController < ApplicationController
	def show
		@topics = { :topic => {title: 'Bugs', image: "http://cdn.wonderfulengineering.com/wp-content/uploads/2014/07/HD-landscape-Photographs.png" } }  

# 		<div class = "topic-read">	
# 		<ul class = "thumbnails">
# 			<li class="span4">Bugs<a href="#" class="thumbnail">
#     <img src="http://cdn.wonderfulengineering.com/wp-content/uploads/2014/07/HD-landscape-Photographs.png" alt="">
#     </a></li>
# 			<li class="span4">Features<a href="#" class="thumbnail">
#     <img src="http://www.deshow.net/d/file/cartoon/2008-12/bob-ross-landscape-painting-281-2.jpg" alt="">
#     </a></li>
#     <li class="span4">God Wishes<a href="#" class="thumbnail">
#     <img src="http://digital-photography-school.com/wp-content/uploads/flickr/3943872114_385146c8fb_o.jpg" alt="">
#     </a></li>
# 		</ul>
# </div>
	end

end
