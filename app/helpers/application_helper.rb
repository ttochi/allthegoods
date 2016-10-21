module ApplicationHelper
    def array_to_select_options(array)
        array.each_with_index.map { |name, index| [name, index] }
    end

    def thumbor_url(string, width, height)
        if string.nil? or string.blank?
            str = ''
        else
            string.slice!(0)
            str = 'http://dhovfqpx3x9uo.cloudfront.net/unsafe/' + width.to_s + 'x' + height.to_s + string
        end

        str
    end
end
