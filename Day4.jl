function day4()
    data = hcat(collect.(readlines("Data\\day4.txt"))...)
    count_array = count_neighbours(data)
    moveable = data .== '@' .&& count_array .< 4
    part1 = count(moveable)
    part2 = copy(part1)
    while true
        data[moveable] .= '.'
        count_array = count_neighbours(data)
        moveable = data .== '@' .&& count_array .< 4
        new = count(moveable)
        part2 += new
        new == 0 && break
    end
    return part1,part2
end

const adj_directions = CartesianIndex.([-1,-1,-1,0,0,1,1,1],[-1,0,1,-1,1,-1,0,1])

function check_bounds(A,cart)
    (cart[1] < 1 || cart[2] < 1) && return false
    a,b = size(A)
    (cart[1] > a || cart[2] > b) && return false
    return true
end

function count_neighbours(data)
    count_array = zeros(Int,size(data)...)
    for loc in findall(data .== '@')
        neighbours = [loc + x for x in adj_directions]
        count_array[neighbours[check_bounds.([count_array],neighbours)]] .+= 1
    end
    return count_array
end