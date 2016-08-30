defmodule Raytracer.Sphere do
    defstruct origin: nil, radius: nil, material: nil

    def hit(sphere, ray, t_min, t_max, current) do
        oc = ray.origin |> Raytracer.Vec3.subtract(sphere.origin)
        a = ray.direction |> Raytracer.Vec3.dot(ray.direction)
        b = oc |> Raytracer.Vec3.dot(ray.direction)
        c = (oc |> Raytracer.Vec3.dot(oc)) - (sphere.radius * sphere.radius)
        discriminant = (b * b) - (a * c)

        if discriminant > 0 do
            temp = (-b - :math.sqrt(b*b - a*c))/a
            if temp < t_max && temp > t_min do
                p = Raytracer.Ray.point_at(ray, temp)
                hitrec = %Raytracer.HitRecord{
                    t: temp,
                    p: p,
                    normal: Raytracer.Vec3.subtract(p, sphere.origin) |> Raytracer.Vec3.scale(1/sphere.radius),
                    material: sphere.material
                }
                {:ok, hitrec}
            else
                temp2 = (-b + :math.sqrt(b*b - a*c))/a
                if temp2 < t_max && temp2 > t_min do
                    p = Raytracer.Ray.point_at(ray, temp)
                    hitrec = %Raytracer.HitRecord{
                        t: temp2,
                        p: p,
                        normal: Raytracer.Vec3.subtract(p, sphere.origin) |> Raytracer.Vec3.scale(1/sphere.radius),
                        material: sphere.material
                    }
                    {:ok, hitrec}
                else
                    {:err, nil}
                end
            end
        else
            {:err, nil} 
        end
    end
end