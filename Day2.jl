function day2()
    data = [parse.(Int,x) for x in split.(split(read("Data/day2.txt",String),","),"-")]
    ranges = [range(x[1],x[2]) for x in data]
    split_ranges!(ranges)
    filter!(x -> ndigits(x[1]) .> 1,ranges)
    part1 = 0
    for r in ranges
        isodd(ndigits(r[1])) && continue
        part1 += test_range(r,Int(ndigits(r[1])/2))
    end
    max_l = maximum(ndigits.(last.(ranges)))
    fac_table = [findall([n % x == 0 for x in 1:floor((n)/2)]) for n in 1:max_l]
    part2 = 0
    for r in ranges
        vals = unique(vcat(find_vals.([r],fac_table[ndigits(r[1])])...))
        part2 += sum(vals[in.(vals,[r])])
    end
    return part1,part2
end

function split_ranges!(ranges)
    for (i,r) in enumerate(ranges)
        ndigits(first(r)) == ndigits(last(r)) && continue
        ranges[i] = first(r):(10^ndigits(first(r))-1)
        push!(ranges,(10^ndigits(first(r))):last(r))
    end
end

function fill_num(v,n,k)
    return v + sum([v*(10^n)^x for x in 1:k-1])
end

function test_range(r,n)
    l = ndigits(r[1])
    k = Int(l/n)
    v1 = floor(Int,r[1]/10^(l-n))
    vn = floor(Int,r[end]/10^(l-n))
    vals = [fill_num(v,n,k) for v in v1:vn]
    return sum(vals[in.(vals,[r])])
end

function find_vals(r,n)
    l = ndigits(r[1])
    k = Int(l/n)
    v1 = floor(Int,r[1]/10^(l-n))
    vn = floor(Int,r[end]/10^(l-n))
    return [fill_num(v,n,k) for v in v1:vn]
end