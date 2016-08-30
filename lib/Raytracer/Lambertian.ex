defmodule Raytracer.Lambertian do
    defstruct albedo: nil

    defimpl Raytracer.Material, for: Raytracer.Lambertian do
      def scatter(material, ray, hit_record) do
          target = hit_record.p 
            |> Raytracer.Vec3.add(hit_record.normal)
            |> Raytracer.Vec3.add(Raytracer.Material.random_in_unit_sphere)

          scattered = %Raytracer.Ray{
              origin: hit_record.p,
              direction: target |> Raytracer.Vec3.subtract(hit_record.p)
          }
          {:ok, material.albedo, scattered}
      end
    end
end