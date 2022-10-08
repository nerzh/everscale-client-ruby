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







# queue = Queue.new
# p 11
# thread = Thread.new do
#   queue.push :ready
#   sleep 1
#   p 0
#   # background work
# end
# thread = Thread.new do
#   queue.push :ready
#   sleep 2
#   p 0
#   # background work
# end
# thread = Thread.new do
#   queue.push :ready
#   sleep 3
#   p 0
#   # background work
# end
# thread = Thread.new do
#   queue.push :ready
#   sleep 4
#   p 0
#   # background work
# end
# p 12
# queue.pop
# p 13





# mutex = Mutex.new
# cv = ConditionVariable.new
# p Thread.current
# a = Thread.new {
#   p Thread.current
#   sleep 3
#   mutex.synchronize {
#     puts "A: I have critical section, but will wait for cv"
#     cv.wait(mutex)
#     puts "A: I have critical section again! I rule!"
#   }
# }

# puts "(Later, back at the ranch...)"

# b = Thread.new {
#   p Thread.current
#   sleep 4
#   mutex.synchronize {
#     puts "B: Now I am critical, but am done with cv"
#     cv.signal
#     puts "B: I am still critical, finishing up"
#   }
# }

# a.join
# b.join
# p 1111








# mutex = Mutex.new
# condition = ConditionVariable.new

# thread = Thread.new do
#   mutex.synchronize do
#     Thread.current[:started] = true
#     sleep 3
#     condition.signal
#   end
#   # background work
# end

# thread2 = Thread.new do
#   mutex.synchronize do
#     Thread.current[:started] = true
#     sleep 4
#     condition.signal
#   end
#   # background work
# end

# mutex.synchronize do
#   condition.wait(mutex) if !thread[:started]
#   condition.wait(mutex) if !thread2[:started]
#   p 1
# end

# p 2



# class C
#   def initialize
#     @mutex = Mutex.new
#     @condition = ConditionVariable.new
#   end

#   def sync
#     @mutex.synchronize do
#       Thread.current[:started] = true
#       yield() if block_given?
#       @condition.signal
#     end
#   end

#   def wait(thread)
#     @mutex.synchronize do
#       @condition.wait(@mutex) if !thread[:started]
#       @condition.wait(mutex) if !thread2[:started]
#       p 1
#     end
#   end
# end










# class Rendezvous
#   include MonitorMixin
#   def initialize
#     super
#     @arrived_cond = new_cond
#     @removed_cond = new_cond
#     @box = nil
#     @arrived = false
#   end

#   def send(obj)
#     synchronize do
#       @removed_cond.wait_while { @arrived }
#       @arrived = true
#       @box = obj
#       @arrived_cond.broadcast
#       @removed_cond.wait
#     end
#   end

#   def recv
#     synchronize do
#       @arrived_cond.wait_until { @arrived }
#       @arrived = false
#       @removed_cond.broadcast
#       return @box
#     end
#   end
# end






m = Monitor.new
c = m.new_cond
c2 = m.new_cond

# m.enter
# Thread.new { sleep 3; m.exit }

# m.synchronize
# m.wait_for_cond
q = Thread.new { m.synchronize { sleep 3; p 1; c.signal } }
a = Thread.new { m.synchronize { sleep 6; p 2; c2.signal } }

# q.join
# a.join

m.synchronize do
  c.wait
end
m.synchronize do
  c2.wait
end

# p c.methods
# p m.methods






























