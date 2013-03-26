class PhotoFilterController

  # Method for increasing the intensity of
  # the current filter
  def filtered_image_with_increased_intensity(image)

    @current_intensity ||= 0

    image_for_filter(@current_filter,
                     image,
                     @current_intensity + 0.3)
  end


  # Method for reducing the intensity of 
  # the current filter
  def filtered_image_with_decreased_intensity(image)

    @current_intensity ||= 0

    image_for_filter(@current_filter,
                     image,
                     @current_intensity - 0.3)
  end


  # Method for generating the Image Filters
  def image_for_filter(filter,
                       image,
                       intensity)

    # Assign the filter and intensity into a property
    # for later use
    @current_filter = filter
    @current_intensity = intensity

    filtered_image = image

    # Determinate the kind of filter using the symbol
    case filter

      when :pixellate

        filtered_image = image_for_pixellate_filter(image,
                                                    intensity)

      when :sepia_tone

        filtered_image = image_for_sepia_tone_filter(image,
                                                     intensity)

      when :color_monochrome

        filtered_image = image_for_color_monochrome_filter(image,
                                                           intensity)

      when :gaussian_blur

         filtered_image = image_for_gaussian_blur_filter(image,
                                                         intensity)

    end

    # Return the Filtered Image
    filtered_image
  end


  # Method for adding the Pixellate Filter to the Image
  def image_for_pixellate_filter(image, scale)

    # Create an instance of an CIImage so Core Image
    # can work with it
    image_to_filter = CIImage.alloc.initWithImage(image)

    # Get a new Core Image Context
    core_image_context = CIContext.contextWithOptions(nil)

    # Create the filter
    filter = CIFilter.filterWithName("CIPixellate")

    # Set the default values to the filter
    filter.setDefaults

    # Add the settings for the filter like the scale, 
    # intensity, etc.
    filter.setValue(image_to_filter, forKey:KCIInputImageKey)
    filter.setValue(scale, forKey:"inputScale")

    # Get the output of the filter to create our return
    # images
    filter_output = filter.outputImage

    # Using the filter output create a new CIImage
    filtered_image = core_image_context.createCGImage(filter_output, 
                                                      fromRect:filter_output.extent)

    # Return a new UIImage from the CIImage created with
    # the filter
    UIImage.imageWithCGImage(filtered_image)    
  end


  # Method for adding the Sepia Tone Filter to the Image
  def image_for_sepia_tone_filter(image, intensity)

    # Create an instance of an CIImage so Core Image
    # can work with it
    image_to_filter = CIImage.alloc.initWithImage(image)

    # Get a new Core Image Context
    core_image_context = CIContext.contextWithOptions(nil)

    # Create the filter
    filter = CIFilter.filterWithName("CISepiaTone")

    # Set the default values to the filter
    filter.setDefaults

    # Add the settings for the filter like the scale, 
    # intensity, etc.
    filter.setValue(image_to_filter, forKey:KCIInputImageKey)
    filter.setValue(intensity, forKey:"inputIntensity")

    # Get the output of the filter to create our return
    # images
    filter_output = filter.outputImage

    # Using the filter output create a new CIImage
    filtered_image = core_image_context.createCGImage(filter_output, 
                                                      fromRect:filter_output.extent)

    # Return a new UIImage from the CIImage created with
    # the filter
    UIImage.imageWithCGImage(filtered_image)    
  end


  # Method for adding the Color Monochrome Filter to the Image
  def image_for_color_monochrome_filter(image, intensity)

    # Create an instance of an CIImage so Core Image
    # can work with it
    image_to_filter = CIImage.alloc.initWithImage(image)

    # Get a new Core Image Context
    core_image_context = CIContext.contextWithOptions(nil)

    # Create the filter
    filter = CIFilter.filterWithName("CIColorMonochrome")

    # Set the default values to the filter
    filter.setDefaults

    # Add the settings for the filter like the scale, 
    # intensity, etc.
    filter.setValue(image_to_filter, forKey:KCIInputImageKey)
    filter.setValue(CIColor.colorWithString('1.000 0.000 0.113 1.000'), forKey:"inputColor")
    filter.setValue(intensity, forKey:"inputIntensity")

    # Get the output of the filter to create our return
    # images
    filter_output = filter.outputImage

    # Using the filter output create a new CIImage
    filtered_image = core_image_context.createCGImage(filter_output, 
                                                      fromRect:filter_output.extent)

    # Return a new UIImage from the CIImage created with
    # the filter
    UIImage.imageWithCGImage(filtered_image)    
  end


  # Method for adding the Gaussian Blur Filter to the Image
  def image_for_gaussian_blur_filter(image, radius)

    # Create an instance of an CIImage so Core Image
    # can work with it
    image_to_filter = CIImage.alloc.initWithImage(image)

    # Get a new Core Image Context
    core_image_context = CIContext.contextWithOptions(nil)

    # Create the filter
    filter = CIFilter.filterWithName("CIGaussianBlur")

    # Set the default values to the filter
    filter.setDefaults

    # Add the settings for the filter like the scale, 
    # intensity, etc.
    filter.setValue(image_to_filter, forKey:KCIInputImageKey)
    filter.setValue(radius, forKey:"inputRadius")

    # Get the output of the filter to create our return
    # images
    filter_output = filter.outputImage

    # Using the filter output create a new CIImage
    filtered_image = core_image_context.createCGImage(filter_output, 
                                                      fromRect:filter_output.extent)

    # Return a new UIImage from the CIImage created with
    # the filter
    UIImage.imageWithCGImage(filtered_image)    
  end

end
