function day5()
    ranges, vals = read_ingredients("Data\\Day5.txt")
    part1 = check_ranges(ranges,vals)
    part2 = find_range_length(ranges)
    return part1,part2
end

function read_ingredients(path)
    data = readlines(path)
    p = findfirst(data .== "")
    ranges = [range(parse.(Int,split(x,'-'))...) for x in data[1:p-1]]
    vals = parse.(Int,data[p+1:end])
    return ranges, vals
end

function check_ranges(ranges,vals)
    fresh = [false for _ in eachindex(vals)]
    for x in ranges
        fresh[in.(vals,[x])] .=  true
    end
    return count(fresh)
end

function find_range_length(ranges)
    a = first.(ranges)
    b = last.(ranges)
    check_order = sortperm(a)
    curr = 0
    total = 0
    for i in check_order
        b[i] <= curr && continue
        x = max(a[i],curr+1)
        curr = b[i]
        total += (curr - x + 1)
    end
    return total
end