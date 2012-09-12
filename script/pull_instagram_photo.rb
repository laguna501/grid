accounts = Account.includes(:photos).where("access_token IS NOT NULL").where(social_type: "instagram")
accounts.each do |account|
  client = Instagram.client(:access_token => account.access_token)
  count = 20
  until count < 20
    all_photo = Photo.where(account_id: account.id).map(&:identifier)
    medias = client.user_recent_media(options = {max_id: (all_photo.last rescue nil), count: 20})
    medias.each do |media|
      next if all_photo.include?(media.id)
      next if media.caption.blank?
      next unless media.caption.text =~ /#grid/
      photo = Photo.new
      photo.identifier = media.id
      photo.account_id = account.id
      photo.thumbnail = photo.save_file(account.username, media.images.low_resolution.url, account.social_type, "full")
      photo.full = photo.save_file(account.username, media.images.standard_resolution.url, account.social_type, "thumbnail")
      photo.save
    end
    count = medias.count
  end
end