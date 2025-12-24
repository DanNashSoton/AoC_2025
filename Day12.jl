function day12()
    pres,all_sizes,all_reqs = parse_input("Data\\Day12.txt")
    not_possible = (sum.(all_reqs) .* 7) .>= (getindex.(all_sizes,1) .* getindex.(all_sizes,2))
    no_packing_neccessary = (sum.(all_reqs) .* 9) .<= (getindex.(all_sizes,1) .* getindex.(all_sizes,2))
    any(.!(not_possible) .& .!(no_packing_neccessary)) && error("UNCERTAIN, CALCULATE PACKING")
    return count(no_packing_neccessary)
end

function parse_input(path)
    raw_data = split(read(path,String),"\r\n\r\n")
    pres_raw = [split(x,"\r\n")[2:end] for x in raw_data[1:end-1]]
    regions = split(raw_data[end],"\r\n")
    pres = [[p[x][y] for x in 1:3, y in 1:3] .== '#' for p in pres_raw]
    sizes = [parse.(Int,split(split(x,":")[1],'x')) for x in regions]
    reqs = [parse.(Int,split(split(x,":")[2],' ')[2:end]) for x in regions]
    return pres,sizes,reqs
end