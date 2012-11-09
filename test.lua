require("answer")

cases    = 0
failures = 0
for line in io.lines("patterns.tsv") do
    for name, input, expected in string.gmatch(line,"(%S+)\t(%S+)\t(%S+)") do
        cases = cases + 1
        actual = solve(input)
        if actual ~= expected then
            failures = failures + 1
            print(string.format("Failuer in %s", name))
            print(string.format("expected: %s", expected))
            print(string.format("  actual: %s", actual))
        end
    end
end

print()
print(string.format("Cases: %d  Failures: %d", cases, failures))