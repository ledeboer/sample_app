class String

  def smurf
    self.split.each {
      |word|
      if (   word.downcase != "me" &&
          word.downcase != "my" &&
          word.downcase != "the" &&
          word.downcase != "to" &&
          word.downcase != "you" )
      then
        if word[-1] == 's' 
        then
          word.replace "smurfs"
        else
          word.replace "smurf"
        end
      end
    
  }.join(" ")
  end
end
