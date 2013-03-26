class User

  attr_accessor :username

  def self.isLogged?
    NSUserDefaults.standardUserDefaults.boolForKey("isUserLogged")        
  end  

  def logIn
    NSUserDefaults.standardUserDefaults.setObject(username, 
      forKey:"loggedUser")

    NSUserDefaults.standardUserDefaults.setBool(true, 
      forKey:"isUserLogged")
    NSUserDefaults.standardUserDefaults.synchronize
  end

  def self.logout
    NSUserDefaults.standardUserDefaults.removeObjectForKey("loggedUser")
    NSUserDefaults.standardUserDefaults.setBool(false, 
      forKey:"isUserLogged")
    NSUserDefaults.standardUserDefaults.synchronize
  end  

end  