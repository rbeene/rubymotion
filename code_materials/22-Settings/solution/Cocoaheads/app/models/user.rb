class User

	def self.logIn (username)
		NSUserDefaults.standardUserDefaults.setObject(username, forKey: "loggedUser")
		NSUserDefaults.standardUserDefaults.setBool(true, forKey: "isUserLogged")
		NSUserDefaults.standardUserDefaults.synchronize
	end

	def self.logOut
		NSUserDefaults.standardUserDefaults.removeObjectForKey("loggedUser")
		NSUserDefaults.standardUserDefaults.setBool(false, forKey: "isUserLogged")
		NSUserDefaults.standardUserDefaults.synchronize
	end

	def self.isLogged?
		NSUserDefaults.standardUserDefaults.boolForKey("isUserLogged")
	end

end