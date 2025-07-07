# frozen_string_literal: true

def bubble_sort(list)
  result = []
  remains = list.clone

  until remains.empty?
    min_offset = 0
    min_value = 99_999_999_999_999_999_999
    remains.each_with_index do |elem, idx|
      if elem < min_value
        min_offset = idx
        min_value = elem
      end
    end
    result.push(min_value)
    remains.delete_at(min_offset)
  end
  result
end
