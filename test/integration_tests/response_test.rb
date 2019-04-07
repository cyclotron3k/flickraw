# -*- coding: utf-8 -*-

require "test_helper"

class ResponseTest < Minitest::Test

  def test_response_keys_are_turned_into_methods
    subject = Flickr::Response.new({ 'le_gal' => 'ok', }, nil)

    assert_equal true, subject.methods.include?(:le_gal)
    assert_equal 'ok', subject.le_gal
  end

  def test_invalid_keys_are_skipped
    response_hash = {
      'illegal; end; raise "Pwned"; def x' => 'skipped'
    }

    Flickr::Response.new(response_hash, nil)

    subject = Flickr::Response.new(response_hash, nil)
    assert_equal false, subject.methods.include?(:illegal)
  end

end
