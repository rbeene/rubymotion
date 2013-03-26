class Movie < NSManagedObject

  # Core Data attributes for the object, this attributes will be used
  # for all the operations like Persisting and Searching
  @attributes ||= [

    # We have to define the names and types of the attributes, also
    # you can set a default value or if it is required

    #Attribute Name, Type, Default Value, Is Optional, Is Transient, Is Indexed
    ['name', NSStringAttributeType, '', false, false, false],
    ['release_year', NSInteger32AttributeType, 0, false, false, false],
    ['studio', NSStringAttributeType, '', false, false, false]

  ]

  # In Core Data we can have relationship between objects, so lets add one 
  # to the Director Object
  @relationships ||= [

    # IMPORTANT: In Core Data is required to have a circular relationships between
    # the two objects. In these case we are adding a Relationship from Movie to Director
    # but also we will need one from Director to Movie, these relationship is called Inverse
    # Relationship
    
    # Relationship Name, Relationship Class, Inverse Relationship, Is Optional, Is Indexed, 
    # Is Ordered, Min Count, Max Count, Delete Rule
    ['director', 'Director', 'movie', true, false, true, 0, 1, NSNullifyDeleteRule]
  ]

end
