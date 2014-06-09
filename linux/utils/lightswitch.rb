#Simple script to manipulate lightness on UNIX using xbacklight

light_value = `xbacklight -get`.to_i
print "Lightness at #{light_value}"
loop_guard = true
while loop_guard
  value=gets.chomp
  print "\n"
  if value == '+'
    light_value += 10.0
    if light_value >= 100.0
      light_value = 100.0
    end
    command = "xbacklight -set #{light_value}"
    print "Lightness at #{light_value}"
    system command
  elsif value == '-'
    light_value -= 10.0
    if light_value <= 0
      light_value = 0.0
    end
    command = "xbacklight -set #{light_value}"
    print "Lightness at #{light_value}"
    system command
  elsif value =='q'
    loop_guard = false
  end
end
