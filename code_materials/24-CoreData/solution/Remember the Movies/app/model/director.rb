# Please note that the Director Model object is child
# of the class NSManagedObject
class Director < NSManagedObject

  # Core Data attributes for the object, this attributes will be used
  # for all the operations like Persisting and Searching
  @attributes ||= [

    # We have to define the names and types of the attributes, also
    # you can set a default value or if it is required

    #Attribute Name, Type, Default Value, Is Optional, Is Transient, Is Indexed
    ['name', NSStringAttributeType, '', false, false, false]
  ]


  # In Core Data we can have relationship between objects, so lets add one 
  # to the Movie Object
  @relationships ||= [

    # IMPORTANT: In Core Data is required to have a circular relationships between
    # the two objects. So lets create the inverse relationship from Director to Movie 
    
    # Relationship Name, Relationship Class, Inverse Relationship, Is Optional, Is Indexed, 
    # Is Ordered, Min Count, Max Count, Delete Rule
    ['movie', 'Movie', 'director', true, false, true, 0, NSIntegerMax, NSCascadeDeleteRule]
  ]

end
