# Eithery Lab, 2016.
# EventHelper.
# Represents a helper class for event related views.

module EventHelper
  def background_class_of(event)
    ['navy-bg', 'yellow-bg', 'red-bg'][event.id % 3]
  end
end
