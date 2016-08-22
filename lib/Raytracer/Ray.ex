defmodule Raytracer.Ray do
    defstruct origin: nil, direction: nil

    def point_at(ray, t) do
        Raytracer.Vec3.add(ray.origin, Raytracer.Vec3.scale(ray.direction, t))
    end
end