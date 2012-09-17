accounts = FacebookAccount.includes(:photos).where("access_token IS NOT NULL").where("accounts.updated_at > ?", Time.now - 60.days)
photos_by_identifier = accounts.map(&:photos).flatten.group_by(&:identifier)
accounts.each do |account|
  fb_user = FbGraph::User.fetch(account.username, :access_token => account.access_token)
  next if fb_user.respond_to?(:error)
  album = fb_user.albums.detect {|album| album.name =~ /Cover Photo/}
  photos = album.photos.select {|photo| photo.name =~ /#grid/ || photos_by_identifier[photo.identifier].blank? }
  photos.each do |photo|
    images = photo.images.sort_by(&:width)
    full = images.reverse.detect {|i| i.width <= 780 }
    photo_type = full.height > full.width ? "portrait" : "landscape"
    thumb = images.detect {|i| [i.height, i.width].min > 350 }
    account.photos.create(
      identifier: photo.identifier,
      description: photo.name,
      full: Photo.save_file(account.username, full.source, account.social_type, "full"),
      thumbnail: Photo.save_file(account.username, thumb.source, account.social_type, "thumbnail")
    )
  end
end

FacebookAccount.includes(:user).each do |facebook_account|
  facebook_account.updated_at + (60 - 4).days < Time.now || facebook_account.extend_access_token
end 