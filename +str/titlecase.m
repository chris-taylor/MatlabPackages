function s = titlecase(s)
%TITLECASE Return a titlecased version of the string where words start with an uppercase character
%and the remaining characters are lowercase. This function deals correctly with apostrophers in
%contractions and possesives. It does not deal with acronyms (e.g. CIA => Cia) which will be
%titlecased along with everything else.
ii    = regexp(s, '[A-Za-z]+(''[A-Za-z]+)?');
s(ii) = upper(s(ii));