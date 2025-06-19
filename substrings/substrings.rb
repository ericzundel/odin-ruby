def find_substring(word, search)
  #puts "find_substring(word=#{word}, search=#{search})"
  return 0 if search.length > word.length
  find_substring(word.slice(1..-1), search) + (word.start_with?(search) ? 1 : 0)
end

def substrings(word, search_for)
  result = {}
  search_for.each do |substring|
    #puts "Calling find_substring(word=#{word}, substring=#{substring})"
    count = find_substring(word, substring)
    if count > 0
      result[substring.to_sym] = count
    end
  end
  result
end
