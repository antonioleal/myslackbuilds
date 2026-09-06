program FibonacciSeries;

var
  n, i       : integer;
  first, second, next : longint;

begin
  write('Enter the number of terms: ');
  readln(n);

  writeln('Fibonacci Series:');

  first  := 0;
  second := 1;

  for i := 1 to n do
  begin
    if i = 1 then
      write(first)
    else if i = 2 then
      write(', ', second)
    else
    begin
      next   := first + second;
      first  := second;
      second := next;
      write(', ', second);
    end;
  end;

  writeln; { newline at the end }
end.
