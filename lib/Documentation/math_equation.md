// This is the math equation we will use to mimic gravity which influences the way the flappy bird falls

- the 'shape' of the fall motion we want to implement for falling physics is a curved U (i.e. parabola)

- this requires two variables, namely height (on the Y-axis), and time (on the a-axis)
basic equation = height/ time

- considerations:

    * acceleration: y'' = -g
    // where y'' is the second derivative of y
    // g is gravity

    * velocity (the integration of y'' [reverse]): y' = -g(t) + v
    // where v is the initial 
    
    * height (the second integration of y''): y = -(g(t)^2)/2 + v(t)
    // --> this is the final formula for gravity

    so if we let g = 9.8 and v = 5 as an example, our fomula would be:
    y = -(9.8(t)^2)/2 + 5t






<copy+paste photo of YT screen shot -> it will be returned as a separate photo in the documentation folder> 