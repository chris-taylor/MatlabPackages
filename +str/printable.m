function chars = printable()
%PRINTABLE String of characters that are considered printable. This is a
%combination of 'digits', 'letters', 'punctuation' and 'whitespace'.
chars = [str.digits str.letters str.punctuation str.whitespace];