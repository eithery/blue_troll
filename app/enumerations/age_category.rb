class AgeCategory < EnumerateIt::Base
  associate_values adult: 0, child: 1, baby: 2
end
