# frozen_string_literal: true

# Implementation of the Caesar Cipher.
# https://www.theodinproject.com/lessons/ruby-caesar-cipher

# value - the character ASCII value to encode
# lowest_char - the character for the lowest letter in the alphabet
# highest_char - the character for the highest letter in the alphabet
# n - the number to add to the ascii value
def rotate(value, lowest_char, highest_char, n)
  if value >= lowest_char.ord && value <= highest_char.ord
    value += n
    value = lowest_char.ord + (value - highest_char.ord) - 1 if value > highest_char.ord
  end
  value
end

def caesar_cipher(plaintext, n)
  ciphertext = ""
  plaintext.chars.each do |c|
    value = rotate(c.ord, "a", "z", n)
    value = rotate(value, "A", "Z", n)
    ciphertext += value.chr
  end
  ciphertext
end

plaintext = ""

if ARGV.length < 2
  puts "Usage: caesar <n> Message to encode ..."
  puts
  puts "n: The number to use to shift the encryption"
  puts "all other arguments are interpreted as the message to encrypt"
  exit 1
end
n = ARGV.shift.to_i
ARGV.each { |w| plaintext += " #{w}" }

puts "plaintext is #{plaintext}"
ciphertext = caesar_cipher(plaintext, n)
puts "ciphertext is #{ciphertext}"
