### AOC 2025
using BenchmarkTools
using Printf

max_day = 5
files = ["Day$x.jl" for x in 1:max_day]
include.(files)

function run_benchmark(max_day)
    funcs = [getfield(@__MODULE__, Symbol("day", x)) for x in 1:max_day]
    total_time = 0.0

    for (day, f) in enumerate(funcs)
        t = @belapsed $f()
        total_time += t
        @printf("Day %d: %.3f ms\n", day, t * 1e3)
    end

    @printf("Total: %.3f ms\n", total_time * 1e3)
    return nothing
end

run_benchmark(max_day)

#= General Testing Functionality

@btime day4()

using Profile

Profile.clear()
@profile for i in 1:100
    day4()
end
Profile.print()

=#