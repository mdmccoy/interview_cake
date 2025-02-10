class Crawler
  require 'digest'

  def initialize
    @known_files = {}
  end

  def traverse_directory_recursive(directory, depth)
    Dir.new(directory).children.each do |child|
      # print_indented(child, depth)
      child_path = File.join(directory, child)

      if File.file?(child_path)
        puts "#{child} is a file (size: #{File.size(child_path)} bytes)"
        file_digest = Digest::SHA256.file(child_path).hexdigest

        if @known_files.key?(file_digest)
          @known_files[file_digest] += [child_path]
        else
          @known_files[file_digest] = [child_path]
        end
      elsif File.directory?(child_path)
        puts "#{child} is a directory"
        traverse_directory(child_path, depth + 1)
      end
    end
  end

  def traverse_directory_iterative(directory)
    file_stack = []
  end

  def print_duplicates
    puts "Print Duplicates:"
    # p @known_files
    @known_files.each do |key, file_path_array|
      determine_duplicate(file_path_array) if file_path_array.size > 1
    end
  end

  private

  def print_indented(string, depth)
    return_value = ''
    depth.times { return_value << '  ' }
    puts return_value + string
  end

  def determine_duplicate(file_paths)
    oldest_file_path = file_paths[0]
    oldest_file_time = File.birthtime(oldest_file_path)
    

    1.upto(file_paths.size - 1) do |index|
      file_to_check = file_paths[index]
      file_to_check_time = File.birthtime(file_to_check)

      if file_to_check_time > oldest_file_time
        oldest_file_path = file_to_check
        oldest_file_time = file_to_check_time
      end
    end

    puts "Of the two files, #{file_paths}"
    puts "#{oldest_file_path} is likely the duplicate"
  end
end

root = '/home/matt/source/interview_cake/test_dir'
depth = 0
myCrawler = Crawler.new
myCrawler.traverse_directory(root, 0)
myCrawler.print_duplicates
