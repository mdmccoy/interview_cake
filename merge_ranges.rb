def merge_ranges(meetings)  
  
  # sort array so that we only have to go through it "once"
  meetings = meetings.sort

  # initialize variables
  new_meeting_times = []
  condensed_meeting = meetings.first
  

  meetings.each_with_index do |meeting, i|
    # skip first element since we already stored it
    next if i == 0

    p "condensed_meeting = #{condensed_meeting}"
    p "meeting = #{meeting}"
    
    if condensed_meeting.last >= meeting.first
      # this is an overlap w/ the condensed meeting, so we need to modify condensed meeting and look the next item
      condensed_meeting = [condensed_meeting.first, [condensed_meeting.last, meeting.last].max]        
    else
      new_meeting_times << condensed_meeting
      condensed_meeting = meeting
    end

    # store our condensed meeting if we're at the end of the array
    new_meeting_times << condensed_meeting if i == meetings.size - 1 
  end

  new_meeting_times
end    

def run_tests
desc = 'meetings overlap'
actual = merge_ranges([[1, 3], [2, 4]])
expected = [[1, 4]]
assert_equal(actual, expected, desc)

desc = 'meetings touch'
actual = merge_ranges([[5, 6], [6, 8]])
expected = [[5, 8]]
assert_equal(actual, expected, desc)

desc = 'meeting contains other meeting'
actual = merge_ranges([[1, 8], [2, 5]])
expected = [[1, 8]]
assert_equal(actual, expected, desc)

desc = 'meetings stay separate'
actual = merge_ranges([[1, 3], [4, 8]])
expected = [[1, 3], [4, 8]]
assert_equal(actual, expected, desc)

desc = 'multiple merged meetings'
actual = merge_ranges([[1, 4], [2, 5], [5, 8]])
expected = [[1, 8]]
assert_equal(actual, expected, desc)

desc = 'meetings not sorted'
actual = merge_ranges([[5, 8], [1, 4], [6, 8]])
expected = [[1, 4], [5, 8]]
assert_equal(actual, expected, desc)

desc = 'oneLongMeetingContainsSmallerMeetings'
actual = merge_ranges([[1, 10], [2, 5], [6, 8], [9, 10], [10, 12]])
expected = [[1, 12]]
assert_equal(actual, expected, desc)

desc = 'sample input'
actual = merge_ranges([[0, 1], [3, 5], [4, 8], [10, 12], [9, 10]])
expected = [[0, 1], [3, 8], [9, 12]]
assert_equal(actual, expected, desc)
end

def assert_equal(a, b, desc)
puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

run_tests
