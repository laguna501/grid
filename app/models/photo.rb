class Photo < ActiveRecord::Base
  belongs_to :user, inverse_of: :photos

  def save_file(facebook_uid, source)
	require 'uri'
	require 'net/http'
    full_url = URI.parse(source) rescue nil
    file_name = full_url.path.split("/").last

    file_path = nil
    Net::HTTP.start( full_url.host ) { |http|
      resp = http.get( full_url.path )
      directory_name = File.join( GRID::Application.config.upload_path, facebook_uid )
      Dir.mkdir(directory_name) unless File.exists?(directory_name)
      open( File.join(directory_name, file_name), 'wb' ) { |file|
        file.write(resp.body)
      }
      file_path = [directory_name, file_name].join("/")
    } 
    return file_path
  end
end
