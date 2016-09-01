defmodule Raytracer.Scenes.Final do
    def render(nx, ny, ns, world, camera) do
        for j <- (ny-1)..0 do
            for i <- 0..(nx-1) do
                render_sample(0, {0, 0, 0}, i, j, nx, ny, ns, world, camera)
            end
        end
    end

    def render_sample(s, c, i, j, nx, ny, ns, world, camera) when s < ns do
         u = (i + :random.uniform) / nx
         v = (j + :random.uniform) / ny
         ray = Raytracer.Camera.get_ray(camera, u, v)
         p = Raytracer.Ray.point_at(ray, 2.0)
         {r1, g1, b1} = Raytracer.Vec3.add(c, colour(ray, world, 0))

         render_sample(s+1, {r1,g1,b1}, i, j, nx, ny, ns, world, camera)
     end

     def render_sample(s, c, i, j, nx, ny, ns, world, camera) do
         Raytracer.Vec3.scale(c, (1/ns))
     end

     def colour(ray, world, depth) do
         case Raytracer.World.hit(world, ray, 0.001, 100000000) do
             {:ok, rec} -> 
                 if depth > 50 do
                     {0, 0, 0}
                 else 
                     case Raytracer.Material.scatter(rec.material, ray, rec) do
                        {:ok, attenuation, scattered} -> {1,1,1}
                        {_,_,_} -> {0,0,0}
                     end
                 end
             {_,_} -> 
                 {x, y, z} = Raytracer.Vec3.unit(ray.direction)
                 t = 0.5 * (y + 1.0)
                 c1 = Raytracer.Vec3.new(1.0, 1.0, 1.0)
                 c2 = Raytracer.Vec3.new(0.5, 0.7, 1.0)
                 Raytracer.Vec3.add(Raytracer.Vec3.scale(c1, 1.0-t), Raytracer.Vec3.scale(c2, t))
         end
     end
   
     def write_to_file(pixels, nx, ny) do
        {:ok, file} = File.open "out.ppm", [:write]
        IO.binwrite file, "P3\n"
        IO.binwrite file, "#{nx} #{ny}\n"
        IO.binwrite file, "255\n"
        Enum.map(pixels, fn {r,g,b} -> IO.binwrite file, "#{round(255.99*r)} #{round(255.99*g)} #{round(255.99*b)}\n" end)
    end
end

:random.seed(:erlang.now)

nx = 200
ny = 100
ns = 100

camera = Raytracer.Camera.new({-2,-2,1}, {0,0,-1},{0,1,0},20,(nx/ny))

world = %Raytracer.World{
    hitable: [
        %Raytracer.Sphere{
            origin: {0,0,-1},
            radius: 0.5,
            material: %Raytracer.Lambertian{
                albedo: {0.1,0.2,0.2}
            }
        },
        %Raytracer.Sphere{
            origin: {0,-100.5,-1},
            radius: 100,
            material: %Raytracer.Lambertian{
                albedo: {0.8,0.8,0.0}
            }
        },
        %Raytracer.Sphere{
            origin: {1,0,-1},
            radius: 0.5,
            material: %Raytracer.Metal{
                albedo: {0.8,0.6,0.2},
                fuzziness: 0.3
            }
        },
        %Raytracer.Sphere{
            origin: {-1,0,-1},
            radius: 0.5,
            material: %Raytracer.Dielectric{
                refractive_index: 1.5
            }
        }
   ]
}

# loop 

{time_ns, output} = :timer.tc(fn ->
  Raytracer.Scenes.Final.render(nx, ny, ns, world, camera)
end) 
 
List.flatten(output)
    |> Raytracer.Scenes.Final.write_to_file(nx, ny) 


time_s = Float.round(time_ns / 1_000, 3)
IO.puts "Completed in #{time_s} ms"