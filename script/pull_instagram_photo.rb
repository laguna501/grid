accounts = InstagramAccount.includes(:photos).where("access_token IS NOT NULL")
accounts.each do |account|
  client = Instagram.client(:access_token => account.access_token)
  all_photo = Photo.where(account_id: account.id).map(&:identifier)
  count = 20
  until count < 20
    medias = client.user_recent_media(options = {max_id: (all_photo.last rescue nil), count: 20})
    medias.each do |media|
      next if all_photo.include?(media.id)
      next if media.caption.blank?
      next unless media.caption.text =~ /#grid/i
      account.photos.create(
        identifier: media.id,
        account_id: account.id,
        thumbnail: Photo.save_file(account.username, media.images.low_resolution.url, account.social_type, "full"),
        full: Photo.save_file(account.username, media.images.standard_resolution.url, account.social_type, "thumbnail")
      )
    end
    count = medias.count
  end
end