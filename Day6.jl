function day6()
    data = readlines("Data\\Day6.txt")
    p = findall([x .!= ' ' for x in data[end]])
    n = length(p)
    push!(p,length(data[end])+2)
    part1 = 0
    part2 = 0
    @views for i in 1:n
        r = p[i]:p[i+1]-2
        if data[end][p[i]] == '*'
            v1 = 1
            v2 = 1
            for j in 1:length(data)-1
                v1 *= parse(Int,data[j][r])
            end
            for k in r
                v2 *= parse(Int,join(getindex.(data[1:end-1],k)))
            end
        else
            v1 = 0
            v2 = 0
            for j in 1:length(data)-1
                v1 += parse(Int,data[j][r])
            end
            for k in r
                v2 += parse(Int,join(getindex.(data[1:end-1],k)))
            end
        end
        part1 += v1
        part2 += v2             
    end
    return part1,part2
end