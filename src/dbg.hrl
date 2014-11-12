trace(List)->
        io:format("[trace] ~p~n", [ List ]).

error_msg(Error)->
        io:format("![error] ~p~n", [ Error ]).
        