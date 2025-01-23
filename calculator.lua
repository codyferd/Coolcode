io.write("Equation: ")
print("Result: " .. (load("return " .. io.read():gsub("=", "")) or error("Invalid"))())
