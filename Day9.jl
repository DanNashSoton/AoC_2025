using Combinatorics
function day9()
    data = readlines("Data\\Day9.txt")
    pos = [parse.(Int,split(x,",")) for x in data]
    dists = [rect_size(pos[x],pos[y]) for (x,y) in combinations(1:length(pos), 2)]
    part1 = maximum(dists)
    part2 = find_max_rect(pos,dists)
    return part1,part2
end

function rect_size(a,b)
    return (abs(a[1]-b[1])+1)*(abs(a[2]-b[2])+1)
end

function find_max_rect(pos,dists)
    pairs = collect(combinations(1:length(pos), 2))[sortperm(dists,rev=true)]
    v_line_x,v_line_range,h_line_y,h_line_range = find_lines(pos)
    for p in pairs
        a = pos[p[1]]; b = pos[p[2]]
        x_range = extrema([a[1],b[1]])
        y_range = extrema([a[2],b[2]])
        test_lines(x_range,y_range,v_line_x,v_line_range) && continue
        test_lines(y_range,x_range,h_line_y,h_line_range) && continue
        return rect_size(a,b)
    end
end

function find_lines(pos)
    pos2 = vcat(pos,[pos[1]])
    v_line_x = Vector{Int}()
    v_line_range = Vector{Vector{Int}}()
    h_line_y = Vector{Int}()
    h_line_range = Vector{Vector{Int}}()
    for p in eachindex(pos)
        if pos2[p][1] == pos2[p+1][1]
            push!(v_line_x,pos2[p][1])
            push!(v_line_range,[pos2[p][2],pos2[p+1][2]])
        else
            push!(h_line_y,pos2[p][2])
            push!(h_line_range,[pos2[p][1],pos2[p+1][1]])
        end
    end
    return v_line_x,sort.(v_line_range),h_line_y,sort.(h_line_range)
end

function test_lines(x_range, y_range, line_coord, line_range)
    idxs = findall((x_range[1] .< line_coord) .& (line_coord .< x_range[2]))
    for i in idxs
        y1, y2 = line_range[i]
        if max(y1, y_range[1]) < min(y2, y_range[2])
            return true
        end
    end
    return false
end