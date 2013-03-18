namespace :facebook do
	desc "Goes through facebook posts with no user_id and attempts to add it if that user has since regestered their Twitter account with the site"
	task :add_user_ids => :environment do
		posts = Post.where(:user_id => -2)
		posts.each do |post|
			if User.exists?(:facebook_id => post.poster_facebook_id)
	          post.user_id = User.find_by_facebook_id(post.poster_facebook_id).id
	          post.save!
	        end
	    end
    end
end