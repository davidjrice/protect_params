# Taken from the Caboo.se blog
# http://blog.caboo.se/articles/2006/06/11/stupid-hash-tricks
# Slightly modified by me (david rice)
class Hash
  
  # lets through the keys in the argument
  # >> {:one => 1, :two => 2, :three => 3}.pass(:one)
  # => {:one=>1}
  def pass(*keys)
    keys.flatten!
    tmp = self.clone
    tmp.delete_if {|k,v| ! keys.include?(k) }
    tmp
  end
  
  # blocks the keys in the arguments
  # >> {:one => 1, :two => 2, :three => 3}.block(:one)
  # => {:two=>2, :three=>3}
  def block(*keys)
    keys.flatten!
    tmp = self.clone
    tmp.delete_if {|k,v| keys.include?(k) }
    tmp
  end
  
end