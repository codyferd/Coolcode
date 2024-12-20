-- Version  1 Will update
local vars = {}
local function eval(expr)
  for var, val in pairs(vars) do expr = expr:gsub(var, tostring(val)) end
  local f, err = load("return " .. expr)
  return f and select(2, pcall(f)) or "Error!"
end
local function adv_ops(cmd)
  local fn, arg = cmd:match("([a-z]+)%(([^)]+)%)")
  arg = tonumber(arg)
  return fn == "sqrt" and math.sqrt(arg)
  or fn == "sin" and math.sin(math.rad(arg))
  or fn == "cos" and math.cos(math.rad(arg))
  or fn == "tan" and math.tan(math.rad(arg))
  or fn == "log" and math.log(arg)
  or fn == "exp" and math.exp(arg)
end
local function set_var(cmd)
  local var, val = cmd:match("([a-zA-Z_][a-zA-Z0-9_]*) = (.+)")
  if var and val then
    local eval_val = eval(val)
    if type(eval_val) == "number" then vars[var] = eval_val return var.."="..eval_val end
  end
end
print("Lua Calculator: +, -, *, /, ^, sqrt(x), sin(x), cos(x), tan(x), log(x), exp(x)\nVars: var = expr. Exit with 'exit'.")
while true do
  io.write("> ")
  local input = io.read()
  if input == "exit" then break end
  print(set_var(input) or adv_ops(input) or eval(input))
end
