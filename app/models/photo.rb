require 'uri'
require 'net/http'
class Photo < ActiveRecord::Base
  attr_accessible :identifier, :description, :full, :thumbnail
  belongs_to :account, inverse_of: :photos

  def self.save_file(username, source, social_type, size)
    full_url = URI.parse(source) rescue return nil
    directory_name = Rails.root.join(*%w(public assets uploads #{social_type} #{size} #{username}))
    file_name = full_url.path.split("/").last

    file_path = File.join(directory_name, file_name)
    Net::HTTP.start( full_url.host ) do |http|
      resp = http.get( full_url.path )
      FileUtils.mkdir_p(directory_name) unless File.exists?(directory_name)
      open(file_path, 'wb' ) do |file|
        file.write(resp.body)
      end
    end
    file_path.gsub(Rails.root.join("public").to_s, "")
  end
end