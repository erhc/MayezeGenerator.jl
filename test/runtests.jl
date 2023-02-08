using Test
using MazeGenerator

function dfs!(maze::Array{Int, 2}, curr::Tuple{Int, Int}, visited::Array{Bool, 2})
    visited[curr[1], curr[2]] = true
    neighbors = [(curr[1] - 1, curr[2]), (curr[1] + 1, curr[2]), 
                 (curr[1], curr[2] - 1), (curr[1], curr[2] + 1)]
    for neighbor in neighbors
        i, j = neighbor
        if i >= 1 && i <= size(maze, 1) && j >= 1 && j <= size(maze, 2) && !visited[i, j] && maze[i, j] == 0
            dfs!(maze, neighbor, visited)
        end
    end
end

function isSolvable(maze::Array{Int, 2}, start::Tuple{Int, Int}, finish::Tuple{Int, Int})
    visited = fill(false, size(maze))
    dfs!(maze, start, visited)
    return visited[finish[1], finish[2]]
end

function hasNoIsolatedRooms(maze::Array{Int, 2})
    n_rows, n_cols = size(maze)
    visited = fill(false, size(maze))
    n_components = 0
    for i in 1:n_rows
        for j in 1:n_cols
            if !visited[i, j] && maze[i, j] == 0
                n_components += 1
                dfs!(maze, (i, j), visited)
                if sum(visited) != sum(maze .== 0)
                    return false
                end
            end
        end
    end
    return n_components == 1
end


@testset "Maze Tests" begin
    @test length(generateMaze(10, 10)[1]) == (2*10 - 1)^2
    @test isSolvable(generateMaze(10, 10, 10)...)
    @test hasNoIsolatedRooms(generateMaze(10, 10, 10)[1])
end