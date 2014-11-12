-module (crud).
-export ([response/2]).
-include ("dbg.hrl").
-include ("settings.hrl").

crud_response(Req, 'GET', "/" ++ ID, DocRoot) ->
	Url = url:fetch( ID ),
	Loc = binary_to_list( Url:get( uri ) ),
	Req:respond({302, [{"Location", Loc}], "Redirect to " ++ Loc });

crud_response(Req, 'POST', "/reduce", DocRoot) ->
	Url = ( url:new( Req:recv_body() ) ):save(),
	Req:ok({ "application/json", Url:get( link ) }).

response(Req, DocRoot) ->
	Path = Req:get(path),
    case filelib:is_regular(DocRoot ++ "/" ++ Path) or (Path =:= "/") or (Path =:= "/favicon.ico") of
    	true ->
    		"/" ++ NormalPath = Req:get(path),
    		Req:serve_file(NormalPath, DocRoot);
    	_ -> crud_response(Req, Req:get(method), Req:get(path), DocRoot)
    end.