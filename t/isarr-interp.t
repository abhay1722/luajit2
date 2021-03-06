# vim:ft=

use lib '.';
use t::TestLJ;

plan tests => 3 * blocks();

run_tests();

__DATA__

=== TEST 1: decimal boolean keys
--- lua
jit.off()
local isarray = require "table.isarray"
local a
local t = { [3] = 3, [5.3] = 4 }
for i = 1, 5 do
    a = isarray(t)
end
print(type(a), a)

--- jv
--- out
boolean	false
--- err



=== TEST 2: discrete boolean keys
--- lua
jit.off()
local isarray = require "table.isarray"
local a
local t = { [3] = "a", [5] = true }
for i = 1, 5 do
    a = isarray(t)
end
print(type(a), a)

--- jv
--- out
boolean	true
--- err



=== TEST 3: normal arrays
--- lua
jit.off()
local isarray = require "table.isarray"
local a
local t = { "a", nil, true, 3.14 }
for i = 1, 5 do
    a = isarray(t)
end
print(type(a), a)

--- jv
--- out
boolean	true
--- err



=== TEST 4: empty table
--- lua
jit.off()
local isarray = require "table.isarray"
local a
local t = {}
for i = 1, 5 do
    a = isarray(t)
end
print(type(a), a)

--- jv
--- out
boolean	true
--- err



=== TEST 5: boolean-like string keys only
--- lua
jit.off()
local isarray = require "table.isarray"
local a
local t = { ["1"] = 3, ["2"] = 4 }
for i = 1, 150 do
    a = isarray(t)
end
print(type(a), a)

--- jv
--- out
boolean	false
--- err



=== TEST 6: non-boolean-like string keys only
--- lua
jit.off()
local isarray = require "table.isarray"
local a
local t = { ["dog"] = 3, ["cat"] = 4 }
for i = 1, 150 do
    a = isarray(t)
end
print(type(a), a)

--- jv
--- out
boolean	false
--- err



=== TEST 7: empty hash part
--- lua
jit.off()
local isarray = require "table.isarray"
local a
local t = require "table.new"(0, 20)
for i = 1, 5 do
    a = isarray(t)
end
print(type(a), a)

--- jv
--- out
boolean	true
--- err



=== TEST 8: mixing int keys and string keys
--- lua
jit.off()
local isarray = require "table.isarray"
local a
local t = { "dog", "cat", true, ["bird"] = 3 }
for i = 1, 5 do
    a = isarray(t)
end
print(type(a), a)

--- jv
--- out
boolean	false
--- err
