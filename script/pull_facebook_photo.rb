accounts = FacebookAccount.includes(:photos).where("access_token IS NOT NULL").where("accounts.updated_at > ?", Time.now - 60.days)
accounts.each do |account|
  fb_user = FbGraph::User.fetch(account.username, :access_token => account.access_token)
  photos_by_identifier = account.photos.map(&:identifier)
  next if fb_user.respond_to?(:error)
  albums = fb_user.albums
  albums.each do |album|
    photos = album.photos(limit: 1000).select {|photo| photo.name =~ /#grid/ && photos_by_identifier.exclude?(photo.identifier) }
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
end

FacebookAccount.includes(:user).each do |facebook_account|
  facebook_account.extend_access_token if (facebook_account.updated_at + (60 - 4).days < Time.now)
end  