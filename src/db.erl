-module (db).
-export ([init/0]).

-include ("records.hrl").
-include ("dbg.hrl").

-define (TIMEOUT, 2000).
init()->
    mnesia:create_schema( [ node() ] ),
        mnesia:start(),
        init_tables(),
    ok.

init_tables() ->
        Node = node(),
        mnesia:create_table( url,[{disc_copies,[Node]}, {type, ordered_set}, {record_name, url}, {attributes, record_info(fields, url)}] ),
        ret_status( mnesia:wait_for_tables( [], ?TIMEOUT ) ).
        
ret_status( ok )-> trace("Tables are ready!");
ret_status( {timeout, BadTables} )->trace("Not all tables are ready: " ++ BadTables);
ret_status( {error, Reason} )-> trace("Error: " ++ Reason).
