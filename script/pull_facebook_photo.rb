accounts = Account.includes(:photos).where("access_token IS NOT NULL").where(social_type: "facebook")
@fb_users = Hash.new
accounts.each do |account|
  @fb_users[account.username] = FbGraph::User.fetch(account.username, :access_token => account.access_token)
end

@user_photos = Hash.new
@fb_users.each do |username, user|
  @user_photos[username] = []
  album = user.albums.detect do |album|
    album.name =~ /Cover Photo/
  end
  album.photos.each do |photo|
    next unless photo.name =~ /#grid/           #fixed description must have #grid word
    @user_photos[username] << photo
  end
end

@user_photos.each do |username, photos|
  account = Account.includes(:photos).where(username: username).first
  all_photo = account.photos.map(&:identifier)
  photos.each do |photo| 
    next if all_photo.include?(photo.identifier)
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

    user_photo.full = user_photo.save_file(username, user_photo.full, account.social_type, "full")
    user_photo.thumbnail = user_photo.save_file(username, user_photo.thumbnail, account.social_type, "thumbnail")
    user_photo.save
  end 
end 