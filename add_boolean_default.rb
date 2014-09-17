ARGF.each_line do |line|
  parts = line.split

  if line.include?('create_table')
    @current_table = parts[1]
  elsif parts.include?('t.boolean') && parts.include?('default:')
    column = parts[1]
    type = parts[0].split('.').last
    value = parts[3]
    ren = "change_column #{@current_table} #{column} :#{type}, default: #{value}"
    ren = ren[0..-2] if ren[-1] == ','

    puts <<-EOS
    begin
      ActiveRecord::Base.connection.#{ren}
      rescue ArgumentError => e
      puts e
    end
    EOS
  end
end
