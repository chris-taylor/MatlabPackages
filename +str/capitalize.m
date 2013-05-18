function result = capitalize(word)
%CAPITALIZE
%
%str.capitalize(word) returns a copy of 'word' with its first character
%capitalized.
%

f      = str.internal.vectorize(@impl);
result = f(word);

function result = impl(word)
result = [upper(word(1)), word(2:end)];