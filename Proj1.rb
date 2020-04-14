# frozen_string_literal: true

def input_check
  if ARGV[0].count('a-zA-Z') > 0
    warn('Incorrect input. You are able to enter only digits')
    0
  elsif ARGV.length > 1
    warn('Incorrect number of input arguments.')
    0
  end
end

def parse_contacts
  input = $stdin.read.downcase.split("\n")
  input = Hash[*input].to_a
  input
end

def check_number(contacts)
  matched_contacts = contacts.map { |x| x.join.include?(ARGV[0]) ? x : nil }
  matched_contacts
end

def check_names(contacts)
  keys_for_matches = generate_keyboard
  new_contacts = []
  (0..keys_for_matches.length - 1).each do |i|
    new_contacts << contacts.map { |x| x.join.include?(keys_for_matches[i]) ? x : nil }
  end
  new_contacts.flatten.compact.uniq
end

def generate_keyboard
  keyboard = %w[abc def ghi jkl mno pqrs tuv wxyz]
  template = ARGV[0].chars.map { |x| keyboard[x.to_i - 2].chars }
  template = template.shift.product(*template).map(&:join)
  template
end

if ARGV != []
  input_check
  contacts = parse_contacts
  number_check = check_number(contacts).compact
  name_check = check_names(contacts).compact
  output = (number_check + name_check).uniq
  if output.flatten.length == 2
    output = output.join(', ')
    puts output
  else
    output = output.map { |x| x.join(', ') }
    puts output
  end
elsif ARGV == []
  parse_contacts.each { |x| puts(x.join(', ').downcase.to_s) }
end
