# frozen_string_literal: true

# Interpreter for YAML template file
class Interpreter
  # source: https://apidock.com/rails/String/camelize
  def self.camelize(string, uppercase_first_letter = true)
    string = if uppercase_first_letter
               string.sub(/^[a-z\d]*/, &:capitalize)
             else
               string.sub(/^(?:(?=\b|[A-Z_])|\w)/, &:downcase)
             end
    string.gsub(%r{(?:_|(/))([a-z\d]*)}) { "#{Regexp.last_match(1)}#{Regexp.last_match(2).capitalize}" }.gsub('/', '::')
  end

  # Print command description after command name
  def self.cmd_desc(ary)
    return '' if ary.nil? || ary.empty?

    str = ary.select { |obj| obj['default'].nil? }.map { |item| item['name'].upcase }.join(' ')
    " #{str}"
  end

  # returns parameters list sorted by mandatory fields
  def self.parameters(ary)
    return '' if ary.nil? || ary.empty?

    ary.select { |obj| obj['default'].nil? } + ary.reject { |obj| obj['default'].nil? }
  end

  def self.param_format!(param_h)
    case param_h['default']
    when nil
      param_h['name'].to_s
    when 'nil', 'true', 'false', true, false
      "#{param_h['name']}=#{param_h['default']}"
    else
      "#{param_h['name']}=\"#{param_h['default']}\""
    end
  end

  def self.print_params(ary)
    return if ary.nil? || ary.empty?

    params = ary.map { |hash| param_format!(hash) }

    "(#{params.join(', ')})"
  end

  def self.add_opt(str, opt, output)
    return '' if opt.nil?
    return '' if opt.respond_to?(:empty?) && opt.empty?

    if str.end_with?(',')
      " #{output}"
    else
      ", #{output}"
    end
  end

  def self.options(ary)
    return '' if ary.nil? || ary.empty?

    ary.map do |opt|
      opt_desc = ''
      opt_desc += add_opt(opt_desc, opt['required'], "required: :#{opt['required']}")
      opt_desc += add_opt(opt_desc, opt['type'], "type: :#{opt['type']}")
      opt_desc += add_opt(opt_desc, opt['short'], "aliases: '-#{opt['short']}'")
      opt_desc += add_opt(opt_desc, opt['desc'], "banner: '#{opt['desc']}'")
      opt_desc += add_opt(opt_desc, opt['default'], "default: '#{opt['default']}'")

      opt_desc = opt_desc[0..-2] if opt_desc.end_with?(',')

      "option :#{opt['name']}#{opt_desc}"
    end.join("\n  ")
  end

  def self.class_opts(ary)
    opts = options(ary)
    return '' if opts.nil? || opts.empty?

    "class_#{opts}"
  end
end
