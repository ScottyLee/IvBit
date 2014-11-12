-module (url).
-export ([new/1, get/2, save/1, fetch/1]).

-include ("records.hrl").
-include ("dbg.hrl").

new(Link) when is_list(Link) -> new( list_to_binary( Link ) );
new(Link) when is_binary(Link) -> #url{id = get_id(), uri = Link}.

get(uri, {?MODULE, _ID, URI})-> URI;
get(id, {?MODULE, ID, _URI})-> ID;

get(link, {?MODULE, ID, _URI})-> 
		?HOST_PREFIX ++ binary_to_list( ID ).

save( {?MODULE, ID, URI} )->
	Transaction = 	fun()->
						mnesia:write( {?MODULE, ID, URI} )
					end,
	{atomic, Res} =  mnesia:transaction( Transaction ),
	{?MODULE, ID, URI}.

fetch(ID) when is_list(ID) ->
	fetch(list_to_binary(ID));

fetch(ID) when is_binary(ID) ->
        Transaction =   fun()-> 
								mnesia:read(?URL_TABLE, ID)
                        end,
		db_res( mnesia:transaction( Transaction ) ).

db_res( {atomic, [Record]} )-> Record;
db_res( {no_exists, Ret} )-> undefined;
db_res( {aborted, Ret} )-> error_msg(Ret), undefined.