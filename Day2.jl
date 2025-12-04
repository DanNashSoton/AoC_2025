function day2()
    data = [parse.(Int,x) for x in split.(split(read("Data/day2.txt",String),","),"-")]
    list = vcat([range(x[1],x[2]) for x in data]...)
    p1 = check1.(list)
    fac_table = [findall([n % x == 0 for x in 1:floor(n/2)]) for 
        n in 1:ndigits(maximum(list))]
    to_check = fac_table[ndigits.(list)]
    p2 = fast_check_splits.(list,to_check)
    part1 = sum(list[p1])
    part2 = sum(list[p2])
    return part1, part2
end

function check1(val)
    isodd(ndigits(val)) && return false
    line = string(val)
    k = Int(length(line)/2)
    return line[1:k] == line[k+1:end]
end

function fast_check_splits(val,n)
    isempty(n) && return false
    line = string(val)
    for m in n
        check_split(line,m) && return true
    end
    false
end

@views function check_split(line,m)
    k = Int(length(line)/m)
    a = line[1:m]
    for p in 2:k
        a != string(line)[(p-1)*m+1:p*m] && return false
    end
    return true
end