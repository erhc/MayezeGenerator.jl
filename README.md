# MazeGenerator.jl

This package is supposed to be a collection of maze generation algorithms.
For the start only one version, Randomized DFS, is implemented.

## Instalation

The package is not registered and this can be installed in the following way

```
] add https://github.com/erhc/MazeGenerator.jl
```

## Usage

There are two functions that you can use, `generateMaze` and `plotMaze`.

`generateMaze` takes in arguments: `height::Int`, `width::Int`, and an optional `start::Tuple{Int, Int}` which is set to `(1, 1)` by default. It returns a `maze::Array{Int, 2}`, `start::Tuple{Int, Int}` and `goal::Tuple{Int, Int}`.
In the maze, passages are `0` and walls are `1`. Also, the size of the maze will be `(2*height - 1, 2*width - 1)`, to perserve the number of passable cells.

`plotMaze` takes a  `maze::Array{Int, 2}` as input, and plots it in a heatmap. In the future, there will be an option to plot the start and the goal cells.

