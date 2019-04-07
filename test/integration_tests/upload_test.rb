# -*- coding: utf-8 -*-

require "test_helper"

class UploadTest < Minitest::Test

  def setup
    @flickr = ::Flickr.new

    @flickr.access_token = ENV['FLICKR_ACCESS_TOKEN']
    @flickr.access_secret = ENV['FLICKR_ACCESS_SECRET']
  end

  def test_upload
    path = File.dirname(__FILE__) + '/image testée.jpg'
    title = "Titre de l'image testée"
    description = "Ceci est la description de l'image testée"

    assert File.exist? path

    upload = @flickr.upload_photo(
      path,
      :title => title,
      :description => description
    )

    info = @flickr.photos.getInfo :photo_id => upload.to_s

    assert_equal title, info.title
    assert_equal description, info.description

    @flickr.photos.delete :photo_id => upload.to_s
  end

end
