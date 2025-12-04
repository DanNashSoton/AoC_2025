function day1()
    data = readlines("Data\\day1.txt")
    dist = parse.(Int64,[x[2:length(x)] for x in data])
    dir = [x ? -1 : 1 for x in (first.(data) .== 'L')]
    move = dist .* dir
    pos1 = vcat(50,accumulate(+,move) .+ 50)
    exacts = mod.(pos1,100).== 0
    part1 = count(exacts)

    pos2 = floor.(pos1/100)
    pos2[exacts] .-= 0.5
    part2 = Int64(sum(abs.(diff(pos2))))
    return (part1,part2)
end