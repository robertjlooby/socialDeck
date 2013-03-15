namespace :twitter do
	desc "Goes through tweets with no user_id and attempts to add it if that user has since regestered their Twitter account with the site"
	task :add_user_ids => :environment do
		posts = Post.where(:user_id => -1)
		posts.each do |post|
			if User.exists?(:twitter_id => post.tweeter_twitter_id)
	          post.user_id = User.find_by_twitter_id(post.tweeter_twitter_id).id
	          post.save!
	        end
	    end
    end
end