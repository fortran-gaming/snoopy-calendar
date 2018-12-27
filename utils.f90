module utils

implicit none

contains


elemental integer function isleapyear(year)

integer, intent(in) :: year

isleapyear = 0

if(modulo(year,4) /= 0) return

if(modulo(year,100) /= 0) then
  isleapyear = 1
  return
endif

if(modulo(year,400) == 0) isleapyear = 1

end function isleapyear


end module utils
