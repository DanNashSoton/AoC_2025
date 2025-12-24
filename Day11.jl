function day11()
    raw = split.(readlines("Data\\day11.txt"),':')
    from = getindex.(raw,1)
    to = [split(x,' ')[2:end] for x in getindex.(raw,2)]

    names, M = create_matrix(from,to)
    ids = [findfirst(names .== x) for x in ["you","svr","out","fft","dac"]]
    starts = [ids[1],ids[2],ids[5],ids[4],ids[2],ids[4],ids[5]]
    ends = [ids[3],ids[5],ids[4],ids[3],ids[4],ids[5],ids[3]]

    V = zeros(Int,size(M,1),length(starts))
    [V[starts[x],x] = 1 for x in eachindex(starts)]
    out_vec = zeros(Int,length(ends))

    while any(V .> 0)
        V = M*V
        [out_vec[x] += V[ends[x],x] for x in eachindex(ends)]
    end

    part1 = out_vec[1]
    part2 = prod(out_vec[2:4]) + prod(out_vec[5:7])
    return part1,part2
end

function create_matrix(from,to)
    names = unique(vcat(from,vcat(to...)))
    matrix = zeros(Int,length(names),length(names))
    for i in eachindex(from)
        matrix[in.(names,[to[i]]),findfirst(names .== from[i])] .= 1
    end
    return names,matrix
end

#= Alterntive Method Test
using LinearAlgebra
M2 = BigInt.(I-M)
@time M3 = M2^-1 # Too Slow
X = M3*V
prod([round(Int,X[ends[x],x]) for x in eachindex(ends)][5:7])
=#
