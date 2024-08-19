-- using :lua print_r(table)
function Print_r(t)
  local print_r_cache = {}
  local function sub_print_r(sub_t, indent)
    if print_r_cache[tostring(sub_t)] then
      print(indent .. "*" .. tostring(sub_t))
    else
      print_r_cache[tostring(sub_t)] = true
      if type(sub_t) == "table" then
        for pos, val in pairs(sub_t) do
          if type(val) == "table" then
            print(indent .. "[" .. pos .. "] => " .. tostring(sub_t) .. " {")
            sub_print_r(val, indent .. string.rep(" ", string.len(pos) + 8))
            print(indent .. string.rep(" ", string.len(pos) + 6) .. "}")
          elseif type(val) == "string" then
            print(indent .. "[" .. pos .. '] => "' .. val .. '"')
          else
            print(indent .. "[" .. pos .. "] => " .. tostring(val))
          end
        end
      else
        print(indent .. tostring(sub_t))
      end
    end
  end
  if type(t) == "table" then
    print(tostring(t) .. " {")
    sub_print_r(t, "  ")
    print("}")
  else
    sub_print_r(t, "  ")
  end
  print()
end
