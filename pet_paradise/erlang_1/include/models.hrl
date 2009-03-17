-record(pet, {species,       % cat | dog
              weight}).      % Integer

-record(demand, {id,         % Integer
                 rate,       % Float
                 date_begin, % {Year, Month, Day}
                 date_end,   % {Year, Month, Day}
                 pets=[]}).  % [Pet]


