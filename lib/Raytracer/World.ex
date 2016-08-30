defmodule Raytracer.World do
    
    defstruct hitable: nil

    def hit(world, ray, t_min, t_max) do
        hit_any_object(world.hitable, ray, t_min, t_max, nil)
    end

    def hit_any_object([head|tail], ray, t_min, t_max, current) do
        case Raytracer.Sphere.hit(head, ray, t_min, t_max, current) do
            {:ok, hit_record} ->
                hit_any_object(tail, ray, t_min, hit_record.t, hit_record)
            {_, _} ->
                hit_any_object(tail, ray, t_min, t_max, current)
        end
    end

    def hit_any_object([], ray, t_min, t_max, current) do
        if current == nil do
            {:err, nil}
        else
            {:ok, current}
        end
    end

end