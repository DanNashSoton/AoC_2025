using Combinatorics
function day10()
    raw = readlines("Data\\Day10.txt")
    part1 = 0
    part2 = 0

    for line in raw
        parts = split(line)
        target =  [x.== '#' for x in parts[1][2:end-1]]
        n = length(target)
        button_vecs = [occursin.(string.(0:n-1),[x]) for x in parts[2:end-1]]
        joltage = parse.(Int,[m.match for m in eachmatch(r"\d+", parts[end])])
        part1 += solve_p1(target,button_vecs)
        part2 += solve_p2(joltage,button_vecs)
    end
    return part1,part2
end

function solve_p1(target,button_vecs)
    n = length(button_vecs)
    ans_vec = [false for _ in 1:length(button_vecs[1])]
    for i in 1:n
        for combo in combinations(1:n, i)
            push_buttons!(ans_vec,button_vecs[combo])
            target == ans_vec && return i
            ans_vec .= false
        end
    end
end

function push_buttons!(ans_vec,button_vecs)
    for v in button_vecs
        ans_vec[v] .= .!(ans_vec[v])
    end
end

function solve_p2(joltage,button_vecs)
    m = length(button_vecs[1])
    but_tots,but_odds,but_counts = find_combos(button_vecs)
    memo = Dict{NTuple{m,Int64},Int64}()

    function solve_aux(j)
        jt = Tuple(j)
        if haskey(memo,jt)
            return memo[jt]
        elseif all(==(0),j)
            memo[jt] = 0
            return 0
        end
        score = 1000
        target = isodd.(j)
        for i in findall(==(target),but_odds)
            j2 = (j .- but_tots[i]) .÷ 2
            any(<(0),j2) && continue
            score = min(score,but_counts[i] + solve_aux(j2) * 2)
        end
        memo[jt] = score
        return score
    end
    return solve_aux(joltage)
end

function find_combos(button_vecs)
    n = length(button_vecs)
    m = length(button_vecs[1])
    but_tots = Vector{Vector{Int64}}()
    but_odds = Vector{Vector{Bool}}()
    but_counts = Vector{Int64}()
    for i in 0:n
        for combo in combinations(1:n, i)
            out_vec = [sum(getindex.(button_vecs[combo],j)) for j in 1:m]
            push!(but_tots,out_vec)
            push!(but_odds,isodd.(out_vec))
            push!(but_counts,i)
        end
    end
    return but_tots,but_odds,but_counts
end