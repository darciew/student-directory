@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    show_students
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students"
    name = gets.chomp
  end
end

def show_students
  print_header
  print(students)
  print_footer
end

def print_header
  puts "The students of Makers Academy"
  puts "-------------"
end

def print(students)
num_of_students = 0
  until num_of_students == @students.length do
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
    num_of_students += 1
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]] # put all elements of the hash into an array and then convert it all to the string
    csv_line = student_data.join(",") # we join it all together using comma as a separator
    file.puts csv_line # we write this line to the file using the puts method
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r") # we open the file for reading "r"
  file.readlines.each do |line| # we read all lines into an array and iterate over it.
    name, cohort = line.chomp.split(',') # parallel assignment of name and cohort. We split the lines at the comma (this will give us an array with two elements - e.g. [Eddy Evil, november]) and assign it to the name and cohort variables.
    @students << {name: name, cohort: cohort.to_sym} #  we create a new hash and put it into the list of students
  end
  file.close
end

def try_load_students
  filename = ARGV.first # load the data if the file is given to the script as an argument
  return if filename.nil? # see if the argument is given. If not, we just proceed as before and don't do anything.
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit # quits the program
  end
end

try_load_students
interactive_menu
