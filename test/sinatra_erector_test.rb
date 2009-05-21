require File.dirname(__FILE__) + '/test_helper'

class SinatraErectorTest < Test::Unit::TestCase
  def erector_app(&block)
    mock_app {
      use_in_file_templates!
      helpers Sinatra::Erector
      set :views, File.dirname(__FILE__) + '/views'
      get '/', &block
    }
    get '/'
  end

  def test_renders_inline_strings
    erector_app { erector 'p "Hello shrimp!"' }
    assert last_response.ok?
    assert_equal '<p>Hello shrimp!</p>', last_response.body.join
  end

  def test_renders_inline_blocks
    erector_app {
      name = 'Frank & Mary'
      erector do
        p "Hello #{name}!"
      end
    }
    assert last_response.ok?
    assert_equal '<p>Hello Frank &amp; Mary!</p>', last_response.body.join
  end

  def test_renders_erector_files_in_views_path
    erector_app {
      erector :hello, :locals => {:name => "World"}
    }
    assert last_response.ok?
    assert_equal '<p>Hello, World!</p>', last_response.body.join
  end

  def test_renders_in_file_template
    erector_app {
      erector :in_file, :locals => {:name => "Joe"}
    }
    assert last_response.ok?
    assert_equal '<p>Hey Joe</p>', last_response.body.join
  end

  def test_renders_with_layout
    erector_app {
      erector :hello, :layout => :html, :locals => { :name => 'with Layout'}      
    }
    assert last_response.ok?
    assert_equal '<html><head><meta content="text/html; charset=utf-8" http-equiv="Content-Type"/><title>Hello</title></head><body><p>Hello, with Layout!</p></body></html>', last_response.body.join
  end

  def test_raises_error_if_template_not_found
    mock_app {
      helpers Sinatra::Erector
      set :environment, :test
      set :raise_errors, true
      get('/') { erector :no_such_template }
    }
    assert_raises(Errno::ENOENT) { get('/') }
  end
end

__END__

@@ in_file
p "Hey #{@name}"
