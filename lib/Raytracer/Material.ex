defprotocol Raytracer.Material do
  def scatter(material, ray, hitrecord) 
end

