# -*- coding: utf-8 -*-

require "test_helper"

class BootstrappingTest < Minitest::Test

  def setup
    VCR.use_cassette("initialize") do
      @flickr = ::Flickr.new 'api_key', 'shared_secret'
    end
  end

  def test_flickr_api_is_accessible_via_methods
    @flickr.send :build_classes, ['flickr.fully.legal']

    assert_equal true, @flickr.methods.include?(:fully)
    assert_equal true, @flickr.fully.methods.include?(:legal)
  end

  def test_invalid_endpoint_definition
    e = assert_raises(RuntimeError) do
      @flickr.send :build_classes, ['not_flickr.something.method']
    end
    assert_equal "Invalid namespace", e.message
  end

  def test_invalid_keys_are_skipped
    @flickr.send :build_classes, ["flickr.hacked; end; raise 'Pwned'; def x"]

    assert_equal false, @flickr.methods.include?(:hacked)
  end

end
