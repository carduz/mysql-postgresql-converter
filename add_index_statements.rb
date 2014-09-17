ARGF.each_line.grep(/add_index/) do |index_statement|
  puts <<EOS
begin
  ActiveRecord::Base.connection.#{index_statement.strip}
  puts 'Created index ' + %q{#{index_statement.split[4]}}
rescue ArgumentError => e
  puts e
end

EOS
end
