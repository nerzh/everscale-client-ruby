require 'concurrent'
require 'thread'
require 'thwait'
require 'monitor'

class Reminder
	include MonitorMixin
  def initialize
    super
    @item = {}
    @serial = 0
  end
# In the preceding code, MonitorMixin is included inside Reminder. To initialize MonitorMixin, call the super method inside the initialize method of Reminder.

# Now let’s add a synchronize method inside each method. Because MonitorMixin is already included, we’ll call its own method, unlike @mutex.synchronize of the Mutex version.

 	def add(str)
 	  synchronize do
 	    @serial += 1
 	    @item[@serial] = str
 	    @serial
 	  end
 	end
 	
 	def delete(key)
 	  synchronize do
 	    @item.delete(key)
 	  end
 	end
 	
 	def to_a
 	  synchronize do
 	    @item.keys.sort.collect do |k|
 	      [k, @item[k]]
 	    end
 	  end
 	end
# Because the synchronize method of MonitorMixin can handle nested locks, you don’t have to worry about having a deadlock, unlike in the Mutex version.

 	def serial
 	  synchronize do
 	    @serial += 1
 	    return @serial
 	  end
 	end
 	
 	def add(str)
 	  synchronize do
 	    key = serial
 	    @item[key] = str
 	    return key
 	  end
	end
end
















# queue = Queue.new


# queue.enq -> { p 1 }
# queue.enq -> { p 2 }
# Thread.new do
# 	queue << proc { |n| p n }
# 	# queue << proc { p 2 }

# 	queue.pop.call(1)
# 	p 2	
# end.join
# queue << proc do |a,b,c,d|
# end
# queue << proc { p 2 }

# Thread.new { sleep3; queue << 1 }

# queue.pop
# queue << proc { p 2 }
# p 2
# queue.pop.call(2)
# queue.pop




# p ThreadsWait.methods




















mutex = Mutex.new
condition = ConditionVariable.new

thread = Thread.new do
  mutex.synchronize do
    Thread.current[:started] = true
    sleep 3
    condition.signal
  end
  # background work
end

thread2 = Thread.new do
  mutex.synchronize do
    Thread.current[:started] = true
    sleep 4
    condition.signal
  end
  # background work
end

mutex.synchronize do
  condition.wait(mutex) if !thread[:started]
  condition.wait(mutex) if !thread2[:started]
  p 1
end

p 2








