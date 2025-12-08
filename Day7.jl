function day7()
    data =  readlines("Data\\Day7.txt")
    splitters = [findall('^',x)::Vector{Int64} for x in data]
    part1 = 0
    beam_mem = zeros(Int,length(data[1]))
    beams = [x == 'S' for x in data[1]]
    beam_mem[beams] .+= 1
    for level in splitters
        isempty(level) && continue
        for i in level
            if beams[i]
                beams[i-1] = true
                beams[i+1] = true
                beams[i] = false
                beam_mem[i-1] += beam_mem[i]
                beam_mem[i+1] += beam_mem[i]
                beam_mem[i] = 0
                part1 += 1
            end
        end
    end
    return part1,sum(beam_mem)
end