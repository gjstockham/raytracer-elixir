defmodule Raytracer.Vec3 do
    
    @doc """
    Creates new vector

    ## Examples
    iex> Raytracer.Vec3.new(3, 4, 5)
    {3, 4, 5}
    """
    def new(x, y, z) do
        {x, y, z}
    end

    @doc """
    Adds two vectors

    ## Examples
    iex> Raytracer.Vec3.add {1, 2, 3}, {4, 5, 6}
    {5, 7, 9}
    """
    def add({x1, y1, z1}, {x2, y2, z2}) do
        {x1 + x2, y1 + y2, z1 + z2}
    end

    @doc """
    Sumtracts two vectors

    ## Examples
    iex> Raytracer.Vec3.subtract {4, 5, 6}, {1, 2, 3}
    {3, 3, 3}
    """
    def subtract({x1, y1, z1}, {x2, y2, z2}) do
        {x1 - x2, y1 - y2, z1 - z2}
    end


    @doc """
    Scales vector

    ## Examples
    iex> Raytracer.Vec3.scale {1, 2, 3}, 2
    {2, 4, 6}
    """
    def scale({x, y, z}, n) do
        {x * n, y * n, z * n}
    end

    @doc """
    Calculates length of a vector

    ## Examples
    iex> Raytracer.Vec3.length {3, 4, 5}
    7.0710678118654755
    """
    def length({x, y, z}) do
        :math.sqrt(length_squared({x, y, z}))
    end

    @doc """
    Calculates the square of the length of a vector

    ## Examples
    iex> Raytracer.Vec3.length_squared {3, 4, 5}
    50
    """
    def length_squared({x, y, z}) do
        (x*x) + (y*y) + (z*z)
    end

    @doc """
    Calculates the cross product of two vectors

    ## Examples
    iex> Raytracer.Vec3.cross {1, 2, 3}, {3, 2, 1}
    {-4, 8, -4}
    """
    def cross({x1, y1, z1}, {x2, y2, z2}) do
         {(y1 * z2 - z1 * y2),
		 (-1 * (x1 * z2 - z1 * x2)),
		 (x1 * y2 - y1 * x2)}
    end

    @doc """
    Calculates the dot product of two vectors

    ## Examples
    iex> Raytracer.Vec3.dot {1, 2, 3}, {3, 2, 1}
    10
    """
    def dot({x1, y1, z1}, {x2, y2, z2}) do
        (x1*x2) + (y1*y2) + (z1*z2)
    end

    @doc """
    Calculates the vector of unit length

    ## Examples
    iex> Raytracer.Vec3.unit {1, 2, 3}
    {0.2672612419124244, 0.5345224838248488, 0.8017837257372732}
    """
    def unit(v) do
       scale(v, 1/Raytracer.Vec3.length(v))
    end

end