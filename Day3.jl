function day3()
    data = readlines("Data/day3.txt")
    part1 = sum(find_max_bat.(data,2))
    part2 = sum(find_max_bat.(data,12))
    return part1, part2
end

function find_max_bat(line,n)
    out = zeros(Int,n)
    p = 1
    vals = parse.(Int,collect(line))
    for i in 1:n
        out[i],q = findmax(vals[p:end-(n-i)])
        p += q
    end
    return parse(Int,*(string.(out)...))
end