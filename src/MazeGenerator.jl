module MazeGenerator


using Random
using DataStructures: Stack
using PlotlyJS
using Colors

export generateMaze, plotMaze


function generateMaze(height::Int, width::Int, start::Tuple{Int, Int}=(1, 1))
    # Function which generates a maze using Randomized DFS.
    # It will return the maze of size(2*height - 1, 2*width - 1) to account for the walls.
    # Walls are represented as 1 and paths as 0
    stack = Stack{Tuple{Int, Int}}()
    grid = Array{Bool}(ones(height*2 -1, width*2 - 1))
    visited = Array{Bool}(zeros(height*2 -1, width*2 -1))
    currentCell = start
    push!(stack, currentCell)
    visited[currentCell...] = 1
    goal = start

    while !isempty(stack)
        currentCell = pop!(stack)

        grid[currentCell...] = 0
        
        unvisitedNeighbors = getUnvisitedNeighbors(currentCell, visited)

        if !isempty(unvisitedNeighbors)
            push!(stack, currentCell)

            nextCell = unvisitedNeighbors[rand(1:length(unvisitedNeighbors))]
            # Remove wall
            grid[(currentCell[1]+nextCell[1])÷2, (currentCell[2]+nextCell[2])÷2] = 0
            
            push!(stack, nextCell)
            visited[nextCell...] = 1
            goal = nextCell
        end
    end
    maze = Array{Int}(zeros(height*2 -1, width*2 - 1))
    maze[grid] .= 1

    return maze, start, goal
end

function getUnvisitedNeighbors(cell::Tuple{Int,Int}, grid::Array{Bool, 2})
    # Function which returns a list of neighbors of the given cell in the grid.
    unvisitedNeighbors = Tuple{Int,Int}[]
    if cell[1] > 2 && !grid[cell[1]-2, cell[2]]
        push!(unvisitedNeighbors, (cell[1]-2, cell[2]))
    end
    if cell[2] > 2 && !grid[cell[1], cell[2]-2]
        push!(unvisitedNeighbors, (cell[1], cell[2]-2))
    end
    if cell[1]+1 < size(grid, 1) && !grid[cell[1]+2, cell[2]]
        push!(unvisitedNeighbors, (cell[1]+2, cell[2]))
    end
    if cell[2]+1 < size(grid, 2) && !grid[cell[1], cell[2]+2]
        push!(unvisitedNeighbors, (cell[1], cell[2]+2))
    end
    return unvisitedNeighbors
end

function plotMaze(maze::Array{Int})
    # Function which plots a heatmap of the maze.
    plot(heatmap(z=maze, showscale=false))
end

end