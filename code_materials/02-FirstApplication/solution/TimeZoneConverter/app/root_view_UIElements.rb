class UIElements

	def local_time_zone_textField

		textField = UITextField.alloc.initWithFrame(CGRectMake(10,50,190,30))
    	textField.borderStyle = UITextBorderStyleRoundedRect
    	textField

	end

	def local_time_zone_textLabel

		label = UILabel.alloc.initWithFrame(CGRectMake(200,50,320,30))
    	label.backgroundColor = UIColor.clearColor;
    	label

	end

	def local_time_zone_button

 		button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
        button.frame = CGRectMake(10,120,305,30)
    	button.setTitle("Select",forState:UIControlStateNormal)
    	button

	end

	def convert_time_zone_textField

		textField = UITextField.alloc.initWithFrame(CGRectMake(10,220,190,30))
		textField.placeholder = "Select Area"
		textField.text = ""
    	textField.borderStyle = UITextBorderStyleRoundedRect
    	textField

	end

	def convert_time_zone_textLabel

		label = UILabel.alloc.initWithFrame(CGRectMake(200,220,320,30))
    	label.backgroundColor = UIColor.clearColor;
        label.text = " UTC - --:--"
    	label

	end

	def convert_time_zone_button

 		button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
        button.frame = CGRectMake(10,290,305,30)
    	button.setTitle("Select",forState:UIControlStateNormal)
    	button

	end


	def convert_button

 		button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
        button.frame = CGRectMake(40,380,250,30)
    	button.setTitle("Convert",forState:UIControlStateNormal)
    	button

	end

	def zone_picker

		picker =  UIPickerView.alloc.initWithFrame(CGRectMake(0,244, 320, 250))
		picker.hidden = true 
		picker.showsSelectionIndicator = true 

		picker

	end


end