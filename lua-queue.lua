-- A queue prototype, FIFO.
-- Originally based on the functional implementation of queues in PIL: https://www.lua.org/pil/11.4.html

-- A note about the the use of index-based arrays in this implementation:
-- "because Lua uses double precision to represent numbers, your [queue] can run for two hundred years, doing one million insertions per second, before it has problems with overflows" - Roberto Ierusalimschy

-- How to use:
--[[
require "lua-queue"
var = Queue:new()
var:push("example")
]]--

Queue = {first = 0, last = -1}

-- Create a new queue.
function Queue:new(object)
    -- create a new object if not provided with one
    local object = object or {}
    setmetatable(object, self)
    self.__index = self
    return object
end

-- Add a new entry to the queue.
function Queue:push(value)
    self.last = self.last + 1
    self[self.last] = value
end

-- Deletes the first entry from the queue.
-- Returns the deleted entry from the queue.
function Queue:pop()
    if(self.first > self.last) then
        error("queue is empty")
    end
    local poppedValue = self[self.first]
    self[self.first] = nil
    self.first = self.first + 1
    return poppedValue
end

-- Get the size of the queue.
function Queue:size()
    return self.last - self.first + 1
end

-- Peek at the first entry of the queue without deleting it.
function Queue:peek()
    return self[self.first]
end

-- Get the nth entry in the queue.
-- Note - not traditionally queue behavior but included because it can be useful.
function Queue:get(n)
    if(n < 1 or n > self:size()) then
        error(n.." is an invalid index")
    end
    return self[self.first + n - 1]
end

-- Set the nth entry in the queue.
-- Note - not traditionally queue behavior but included because it can be useful.
function Queue:set(n, val)
    if(n < 1 or n > self:size()) then
        error(n.." is an invalid index")
    end
    self[self.first + n - 1] = val
end
