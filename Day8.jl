function day8()
    data = readlines("Data\\Day8.txt")
    juncs = [parse.(Int,split(x,',')) for x in data]
    n = length(juncs)
    dists = [sl_dist(j1,j2) for j1 in juncs, j2 in juncs]
    [dists[x,x] += 1000000 for x in 1:n]
    shortest = sortperm(dists[:])
    part1 = 0
    part2 = 0
    hubs = []
    for (i,x) in enumerate(shortest[1:2:end])
        connect = [ceil(Int,x/n),mod1(x,n)]
        to_link = [any(in.(connect,[hub])) for hub in hubs]
        if count(to_link) == 0
            push!(hubs,connect)
        elseif count(to_link) == 1
            new_hub = unique(vcat(hubs[findfirst(to_link)],connect))
            hubs[findfirst(to_link)] = new_hub
        else
            new_hub = unique(vcat(popat!.([hubs],reverse(findall(to_link)))...,connect))
            push!(hubs,new_hub)
        end
        if i == 1000
            hub_sizes = length.(hubs)
            part1 = prod(sort(hub_sizes,rev=true)[1:3])
        elseif length(hubs[1]) == n
            part2 = prod(first.(getindex.([juncs],connect)))
            break
        end
    end
    return part1,part2
end

function sl_dist(j1,j2)
    return sqrt((j1[1]-j2[1])^2+(j1[2]-j2[2])^2+(j1[3]-j2[3])^2)
end