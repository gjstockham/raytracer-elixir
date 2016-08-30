defprotocol Raytracer.Material do
  def scatter(material, ray, hitrecord)

  def random_in_unit_sphere do
      
  end
end