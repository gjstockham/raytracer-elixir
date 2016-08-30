defmodule Raytracer.Camera do
    
    defstruct origin: nil, lower_left_corner: nil,  horizontal: nil, vertical: nil

    def new(origin, look_at, up, fov, aspect) do
        theta = fov * (:math.pi / 180)
        half_height = :math.tan(theta / 2)
        half_width = aspect * half_height
        w = origin |> Raytracer.Vec3.subtract(look_at) |> Raytracer.Vec3.unit
        u = up |> Raytracer.Vec3.cross(w) |> Raytracer.Vec3.unit
        v = w |> Raytracer.Vec3.cross(u)
        lower_left = origin 
            |> Raytracer.Vec3.subtract(Raytracer.Vec3.scale(u, half_width))
            |> Raytracer.Vec3.subtract(Raytracer.Vec3.scale(v, half_height))
            |> Raytracer.Vec3.subtract(w)
        %Raytracer.Camera{
            origin: origin,
            lower_left_corner: lower_left,
            horizontal: Raytracer.Vec3.scale(u, (2*half_width)),
            vertical: Raytracer.Vec3.scale(v, (2*half_height))
        }
    end

    def get_ray(camera, u, v) do
        direction = camera.lower_left_corner 
            |> Raytracer.Vec3.add(Raytracer.Vec3.scale(camera.horizontal, u))
            |> Raytracer.Vec3.add(Raytracer.Vec3.scale(camera.vertical, v))
            |> Raytracer.Vec3.subtract(camera.origin)
        %Raytracer.Ray{
            origin: camera.origin,
            direction: direction
        }
    end
end