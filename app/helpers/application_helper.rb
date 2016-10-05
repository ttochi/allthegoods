module ApplicationHelper
    def array_to_select_options(array)
        array.each_with_index.map { |name, index| [name, index] }
    end
end
