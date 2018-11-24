require "lccnorm/version"


module Lccnorm
  class InvalidLccnError < StandardError; end

  # Normalize LCCN according to Library of Congress rules
  # (https://www.loc.gov/marc/lccn-namespace.html)
  #
  # An LCCN is to be normalized to its canonical form described in the syntax
  # description above, as follows:
  #
  # 1. Remove all blanks.
  # 
  # 2. If there is a forward slash (/) in the string, remove it, and remove all
  # characters to the right of the forward slash.
  #
  # 3. If there is a hyphen in the string:
  #    * Remove it.
  #    * Inspect the substring following (to the right of) the (removed)
  #      hyphen. Then (and assuming that steps 1 and 2 have been carried out):
  #         *  All these characters should be digits, and there should be six
  #            or less.
  #         *  If the length of the substring is less than 6, left-fill the
  #            substring with zeros until the length is six.
  #
  def self.normalize(lccn)
    l, r = lccn.tr(' ', '').split('/')[0].split('-', 2)

    # No hyphen? Easy
    if r.nil?
      return l
    end

    # Make sure there are 6 or fewer characters to the right of the hyphen
    # (there has to be at least on or we already would have returned) and pad to
    # the left with zeros
    if r =~ /\A\d{1,6}\z/
      return l + r.rjust(6, '0')
    end

    # If we get this far, something is wrong with the number
    raise InvalidLccnError.new(
            "%s is not a valid LCCN " % lccn + \
            "(part to the right of hyphen should be 6 numeric characters " + \
            "or fewer")
    
  end

  # Validate LCCN according to Library of Congress rules
  # (https://www.loc.gov/marc/lccn-namespace.html)
  #
  # A normalized LCCN is a character string eight to twelve characters in
  # length. (For purposes of this description characters are ordered from left
  # to right -- "first" means "leftmost".)
  #
  # * The rightmost eight characters are always digits.
  # * If the length is 9, then the first character must be alphabetic.
  # * If the length is 10, then the first two characters must be either both
  #   digits or both alphabetic.
  # * If the length is 11, then the first character must be alphabetic and the
  #   next two characters must be either both digits or both alphabetic.
  # * If the length is 12, then the first two characters must be alphabetic and
  #   the remaining characters digits.
  def self.valid?(lccn)
    if lccn =~ /\A([A-z]{2}\d{2}|([A-z]?([A-z]{2}|\d{2}))|[A-z])?\d{8}\z/
      return true
    end

    return false
  end                                                
end
