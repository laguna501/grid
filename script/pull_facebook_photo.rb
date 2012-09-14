accounts = Account.includes(:photos).where("access_token IS NOT NULL").where(social_type: "facebook").where("accounts.updated_at > ?", Time.now - 60.days)
accounts.each do |account|
  fb_users = FbGraph::User.fetch(account.username, :access_token => account.access_token)
  album = fb_users.albums.detect do |album|
    next unless album.name =~ /Cover Photo/
    album.photos.each do |photo|
      next unless photo.name =~ /#grid/
      next if account.photos.map(&:identifier).include?(photo.identifier)
      user_photo = Photo.new
      user_photo.identifier = photo.identifier
      user_photo.description = photo.name
      user_photo.account = account
      photo.images.sort_by(&:width).reverse.each do |image|
        user_photo.photo_type = image.height > image.width ? "portrait" : "landscape"
        next unless image.width <= 780 && image.width >= 600
        user_photo.full = image.source
        break
      end
      photo.images.each do |image|
        next if image.height < image.width && image.height > 350
        next if image.height > image.width && image.width > 350
        user_photo.thumbnail = image.source
        break
      end
      user_photo.full = user_photo.save_file(account.username, user_photo.full, account.social_type, "full")
      user_photo.thumbnail = user_photo.save_file(account.username, user_photo.thumbnail, account.social_type, "thumbnail")
      user_photo.save
    end
  end
end

facebook_accounts = Account.includes(:user).where(social_type: "facebook")   
facebook_accounts.each do |facebook_account|
  token_life_time = (facebook_account.updated_at + 60.days) - Time.now
  next unless token_life_time  < 4.days
  facebook_account.extend_access_token
end 