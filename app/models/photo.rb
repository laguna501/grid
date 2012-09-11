class Photo < ActiveRecord::Base
  belongs_to :account, inverse_of: :photos

  def save_file(username, source, social_type)
	require 'uri'
	require 'net/http'
    full_url = URI.parse(source) rescue nil
    file_name = full_url.path.split("/").last

    file_path = nil
    Net::HTTP.start( full_url.host ) { |http|
      resp = http.get( full_url.path )
      directory_name = File.join( Rails.root.join(*%w(public assets uploads)), social_type, username )
      FileUtils.mkdir_p(directory_name) unless File.exists?(directory_name)
      open( File.join(directory_name, file_name), 'wb' ) { |file|
        file.write(resp.body)
      }
      file_path = [directory_name, file_name].join("/")
      file_path = file_path.gsub(Rails.root.join(*%w(public)).to_s, "")
    } 
    return file_path
  end
end