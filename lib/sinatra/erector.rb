require 'sinatra/base'
require 'erector'
require 'activesupport'

module Sinatra
  module Erector
    
    include ActiveSupport::CoreExtensions::String::Inflections
    
    # Generate html file using Erector.
    # Takes the name of a template to render as a Symbol and returns a String
    # with the rendered output.
    def erector(template=nil, options={}, locals = {}, &block)
      options, template = template, nil if template.is_a?(Hash)
      template = lambda { block } if template.nil?
      render :erector, template, options, locals
    end

  protected
    def render_erector(template, data, options, locals, &block)
      # puts "---"
      # puts "template=#{template}"
      # puts "data='#{data}'"
      # puts "options.inspect='#{options.inspect}'"
      # puts "locals='#{locals.inspect}'"
      # puts "block='#{block}'"
      
      filename = options.delete(:filename) || '<ERECTOR>'
      line = options.delete(:line) || 1
      
      if data.respond_to?(:to_str)
        widget = ::Erector::Widget.new(locals) do
          eval(data.to_str, binding, filename, line)
        end
        # end
      elsif data.kind_of?(Proc)
        widget = ::Erector::Widget.new(locals, &data)
      end
      widget.to_s
    end
  end

  helpers Erector
end
