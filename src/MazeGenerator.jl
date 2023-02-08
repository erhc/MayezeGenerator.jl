module MazeGenerator

using PlotlyJS
include("RandomizedDFS.jl")

export generateMaze, plotMaze


function generateMaze(height::Int, width::Int, start::Tuple{Int, Int}=(1, 1))
    # This function will take a string as an argument once there are other methods to call
    return randomizedDFS(height, width, start)
end


function plotMaze(maze::Array{Int})
    # Function which plots a heatmap of the maze.
    plot(heatmap(z=maze, showscale=false))
end

end