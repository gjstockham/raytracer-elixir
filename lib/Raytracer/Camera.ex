defmodule Raytracer.Camera do
    
    defstruct origin: nil, lower_left_corner: nil,  horizontal: nil, vertical: nil

    def new(origin, look_at, up, fov, aspect) do
        
    end

    def get_ray(camera, u, v) do
        %Raytracer.Ray{
            
        }
    end
end