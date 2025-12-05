function day4()
    data = hcat(collect.(readlines("Data\\day4.txt"))...) .== '@'
    count_array = count_neighbours(data)
    moveable = findall(data .&& count_array .< 4)
    part1 = length(moveable)
    part2 = copy(part1)
    while true
        data[moveable] .= false
        reduce_count!(count_array,moveable)
        moveable = filter(x -> count_array[x] < 4, findall(data))
        new = length(moveable)
        new == 0 && break
        part2 += new
    end
    return part1,part2
end

const adj_directions = CartesianIndex.([-1,-1,-1,0,0,1,1,1],[-1,0,1,-1,1,-1,0,1])

function count_neighbours(data)
    count_array = zeros(Int,size(data)...)
    a,b = size(data)
    for loc in findall(data)
        for dir in adj_directions
            check_bounds(a,b,loc + dir) && (count_array[loc + dir] += 1)
        end
    end
    return count_array
end

function reduce_count!(count_array,moveable)
    a,b = size(count_array)
    for loc in moveable
        for dir in adj_directions
            check_bounds(a,b,loc + dir) && (count_array[loc + dir] -= 1)
        end
    end
    return nothing
end

function check_bounds(a,b,cart)
    (cart[1] < 1 || cart[2] < 1) && return false
    (cart[1] > a || cart[2] > b) && return false
    return true
end