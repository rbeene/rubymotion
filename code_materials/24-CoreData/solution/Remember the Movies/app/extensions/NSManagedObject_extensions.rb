class NSManagedObject
  def self.entity
    @entity ||= NSEntityDescription.newEntityDescriptionWithName(name, attributes:@attributes, relationships:@relationships)
  end

  def self.objects
    # Use if you do not want any section in your table view
    @objects ||= NSFetchRequest.fetchObjectsForEntityForName(name, withSortKey:@sortKey, ascending:false, inManagedObjectContext:Store.shared.context)
  end

end
