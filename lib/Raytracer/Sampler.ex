defmodule Raytracer.Sampler do
    def random_in_unit_sphere do
        temp = Raytracer.Vec3.new(:random.uniform, :random.uniform, :random.uniform)
        p = temp |> Raytracer.Vec3.scale(2.0) |> Raytracer.Vec3.subtract({1, 1, 1})
        dot = p |> Raytracer.Vec3.dot(p)
        if dot >= 1 do
            temp
        else    
            random_in_unit_sphere
        end
    end
end