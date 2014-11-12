-record (url, {id = undefined, uri = undefined}).

-include ("settings.hrl").
-define (URL_TABLE, url).

get_id() ->
	list_to_binary( get_random_string( ?ID_LENGTH, ?ID_ALOWED_CHARS ) ).

get_random_string(Length, Chs) ->
	random:seed(now()),
    Iterator = fun(_, Acc) -> [lists:nth(random:uniform(length(Chs)), Chs)] ++ Acc end,
    lists:foldl(Iterator, [], lists:seq(1, Length)).
